//
//  BaseMapScene.swift
//  Focus
//
//  Created by Igor Starobor on 10.09.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVKit

protocol BaseMapSceneDelegate: class {
    func didPressedSettings()
}

class BaseMapScene: SKScene, PlayerControlDelegate, PlayerInteractableDelegatet, GamblingViewDelegate {
    
    let players = HorseRacingDataPreparer(data: HorseRacingData())
    var viewController: UIViewController?
    
    var entities: [GKEntity] = []
    var graphs: [String : GKGraph] = [:]
    
    weak var baseSceneDelegate: BaseMapSceneDelegate?
    
    weak var moveComponent: PlayerControlComponent?
    weak var interactComponent: PlayerInteractableButtonsComponent?
    
    
    weak var parentVC: UIViewController?
    
    enum PressedScreenSide {
        case left
        case right
    }
    
    var mainHeroName = "rabbit"
    
    var mainHero: MainCharacter!
    var floors: [SKSpriteNode]!
    var mainCamera: SKCameraNode!
    
    var pressedMovementSide: PressedScreenSide?
    private var lastUpdateTime : TimeInterval = 0
    
    var beganPressednode: SKSpriteNode?
    
    var selectedHero: BaseHero?
    
    override func didMove(to view: SKView) {
        self.lastUpdateTime = 0
        parentVC = self.view?.window?.rootViewController
        
        configureScene()
        configureNodes()
        mainHero.setUpStateMachine()
        configureComponents()
        mainCamera.position = CGPoint(x: mainHero.position.x,
                                      y: mainHero.position.y + UIScreen.main.bounds.height / 2)
    }
    

    override func didSimulatePhysics() {
        let halfOfCameraWidth = mainCamera.calculateAccumulatedFrame().width / 2
        let cameraY = mainHero.position.y + UIScreen.main.bounds.height / 2
        let cameraStartX = mainHero.position.x - halfOfCameraWidth
        let cameraEndX = mainHero.position.x + halfOfCameraWidth
        guard let leftWall = childNode(withName: "leftWall")?.position,
              let rightWall =  childNode(withName: "rightWall")?.position else { return }
        if cameraStartX < leftWall.x {
            mainCamera.position = CGPoint(x: leftWall.x + halfOfCameraWidth, y: cameraY)
        } else if cameraEndX > rightWall.x {
            mainCamera.position = CGPoint(x: rightWall.x - halfOfCameraWidth, y: cameraY)
        } else {
            mainCamera.position = CGPoint(x: mainHero.position.x, y: cameraY)
        }
    }
    
    func configureScene() {
        self.physicsWorld.contactDelegate = self
    }
    
    func configureComponents() {
        if let pcComponent = mainHero.entity?.component(ofType: PlayerControlComponent.self) {
            pcComponent.cNode = mainHero
            pcComponent.setupControls(camera: camera!, scene: self)
            pcComponent.delegate = self
            moveComponent = pcComponent
        }
        
        if let anComponent = mainHero.entity?.component(ofType: AnimateComponent.self) {
            anComponent.cNode = mainHero
        }
        
        if let inbComponent = mainHero.entity?.component(ofType: PlayerInteractableButtonsComponent.self) {
            inbComponent.cNode = mainHero
            inbComponent.delegate = self
            inbComponent.setupControls(camera: camera!, scene: self)
            inbComponent.actionButtonslNode?.isHidden = selectedHero == nil
            interactComponent = inbComponent
        }
        
        if let settComponent = mainHero.entity?.component(ofType: SettingsButtonControlComponent.self) {
            settComponent.cNode = mainHero
            settComponent.delegate = self
            settComponent.setupControls(camera: camera!, scene: self)
        }
    }
    
    func configureNodes() {
        configureMainHero()
        configureFloors()
        configureMainCamera()
    }
    
    func configureMainHero() {
        if let node = self.childNode(withName: mainHeroName) as? MainCharacter {
            mainHero = node
            mainHero.physicsBody = SKPhysicsBody(rectangleOf: mainHero.size)
            mainHero.physicsBody?.isDynamic = true
            mainHero.physicsBody?.categoryBitMask = AppBitMasks.player
            mainHero.physicsBody?.contactTestBitMask = AppBitMasks.floor
            mainHero.physicsBody?.allowsRotation = false
            mainHero.physicsBody?.angularVelocity = 0
        }
    }
    
    func configureFloors() {
        self.floors = []
        enumerateChildNodes(withName: "floor", using: { node, stop in
            if let spriteNode = node as? SKSpriteNode {
                self.floors.append(spriteNode)
            }
        })
        self.floors.forEach({ (node) in
            node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: node.size.width,
                                                                 height: node.size.height * 0.1))
            node.physicsBody?.isDynamic = false
            node.physicsBody?.categoryBitMask = AppBitMasks.floor
        })
    }
    
    func configureMainCamera() {
        mainCamera = SKCameraNode()
        mainCamera.setScale(4)
        self.addChild(mainCamera)
        self.camera = mainCamera
    }
    
    func showDialogWith(texts: [String], hero: Hero) {
        removeDialog()
        let dialog = DialogView(texts: texts, hero: hero)
        parentVC?.view.addSubview(dialog)
        dialog.delegate = self
        dialog.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(120)
            make.trailing.equalTo(-120)
            make.bottom.equalTo(-15)
            make.height.equalTo(80)
        }
    }
    
    func removeDialog() {
        if parentVC?.view.subviews.contains(where: {$0 is DialogView}) ?? true {
            parentVC?.view.subviews.forEach({
                if $0 is DialogView {
                    $0.removeFromSuperview()
                }
            })
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: self) {
            self.beganPressednode = self.atPoint(touchPoint) as? SKSpriteNode
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: self) {
            if let node = self.atPoint(touchPoint) as? SKSpriteNode {
                if beganPressednode == node { /// pressed smae node
                    pressed(node: node)
                }
            }
        }
    }
    
    func pressed(node: SKSpriteNode) {
        if let selectedHero = node as? BaseHero {
            self.selectedHero = selectedHero
            interactComponent?.actionButtonslNode?.isHidden = false
            
            pressedHero(node: selectedHero)
        }
    }
    
    func pressedHero(node: BaseHero) {
        //mainHero.
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        let dt = currentTime - self.lastUpdateTime
        
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
    
    func follow(command: PlayerControlComponent.PlayerControlCommand) {
        selectedHero = nil
        interactComponent?.actionButtonslNode?.isHidden = true
        removeDialog()
    }
    
    func follow(command: PlayerInteractableButtonsComponent.InteractableButtonsCommand) {
        switch command {
        case .pressedTalk:
            break
        case .pressedAction:
            print(selectedHero)
        case .pressedGame:
            interactComponent?.actionButtonslNode?.isHidden = true
            let gamblingVC = GamblingViewController(data: players)
            gamblingVC.delegate = self
            gamblingVC.modalPresentationStyle = .overFullScreen
            viewController?.present(gamblingVC, animated: false)
        }
    }
    
    func selected(index: Int) {
        let model = HorseRacingCML()
        print(index)
        let selectedPlayer = players.data.horses[index]
        for (horseIndex, horse) in players.data.horses.enumerated() {
            guard let horsesOutput = try? model.prediction(hSp: horse.hSp, hAg: horse.hAg, hWe: horse.hWe, hSt: Double(horse.hSt?.rawValue ?? 0), hEx: horse.hEx, rAg: horse.rAg, rWe: horse.rWe, rEx: horse.rEx, rSt: Double(horse.rSt!.rawValue), rFi: horse.rFi, gDi: horse.gDi, gWe: horse.gWe, gTr: horse.gTr, gTi: horse.gTi, tDi: players.data.map.tDi, tWe: players.data.map.tWe, tTr: players.data.map.tTr, tTi: players.data.map.tTi) else {
                fatalError("Unexpected runtime error.")
            }
            players.data.horses[horseIndex].viktories = Int(horsesOutput.victories)
            print("player ID - \(players.data.horses[horseIndex].id)",
                  "player rating - \(players.data.horses[horseIndex].viktories!)")
        }
        
        let winer = players.data.horses.max(by: {$0.viktories ?? 0 < $1.viktories ?? 0})
        
        print("\nSelected player ID - \(selectedPlayer.id)",
              "\nWiner player ID - \(winer!.id)")
        if winer?.id == selectedPlayer.id {
            showDialogWith(texts: ["Ви перемогли"], hero: .radio)
        } else {
            showDialogWith(texts: ["Ви програли"], hero: .radio)
        }
        
    }
    
    
    
}

extension BaseMapScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}


extension BaseMapScene: SettingsButtonControlDelegatet {
    
    func didPressedButton() {
        removeDialog()
        (viewController as? GameViewController)?.setMainMenuScene()
    }
    
}

extension BaseMapScene: DialogViewDelegate {
    
}
