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

class BaseMapScene: SKScene, PlayerControlDelegate, PlayerInteractableDelegatet {
    
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
        
    }
    
    override func didSimulatePhysics() {
        self.mainCamera.position = CGPoint(x: mainHero.position.x, y: mainHero.position.y + UIScreen.main.bounds.height/2)
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
        mainCamera.setScale(6)
        self.addChild(mainCamera)
        self.camera = mainCamera
    }
    
    func showDialogWith(text: String, hero: Hero) {
        removeDialog()
        let dialog = DialogView(text: text, hero: hero)
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
            if let inbComponent = mainHero.entity?.component(ofType: PlayerInteractableButtonsComponent.self) {
                inbComponent.actionButtonslNode?.isHidden = false
            }
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
        
    }
    
    func follow(command: PlayerInteractableButtonsComponent.InteractableButtonsCommand) {
        
    }
    
}

extension BaseMapScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}


extension BaseMapScene: SettingsButtonControlDelegatet {
    
    func didPressedButton() {
        if let vc = self.view?.window?.rootViewController {
            // let gamblingVC = GamblingViewController()
            // gamblingVC.modalPresentationStyle = .overFullScreen
            // vc.present(gamblingVC, animated: true)
        }
    }
    
}

extension BaseMapScene: DialogViewDelegate {
    
}
