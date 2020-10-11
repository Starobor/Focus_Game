//
//  MainMenuScene.swift
//  Focus
//
//  Created by Igor Starobor on 15.02.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol MainMenuDelegate: class {
    func gameIsStart()
}

class MainMenuScene: SKScene {
    
    enum AciveNodesName: String {
        case startButton = "startButtonContainer"
    }
    
    enum ImagesNodesName: String {
        case startButton = "startGameButton"
        case startButtonActive = "startGameButtonActive"
    }
    
    private var rabbitForGenerateConveyor: SKSpriteNode!
    private var rabbitForGenerateCeiling: SKSpriteNode!
    private var startButton: SKSpriteNode!
    private var cageBoxLever: SKSpriteNode!
    private var cageBoxGenerator: SKSpriteNode!
    private var floor: SKSpriteNode!
    
    var isAnimatedCageBoxLever = false
        
    let backgroundSound = SKAudioNode(fileNamed: "main_menu_background.mp3")
    let conveyerSound = SKAudioNode(fileNamed: "ES_Factory Conveyor 1 - SFX Producer.mp3")
    let steamSound = SKAudioNode(fileNamed: "ES_Steam Engine Tractor 34 - SFX Producer (cut)")
    let leverPushSound = SKAudioNode(fileNamed: "ES_Slot Machine Pull 2 - SFX Producer(cut) on")
    var steamVolume = 0.06

    
//ES_Steam Engine Tractor 34 - SFX Producer.mp3
    weak var mainMenuDelegate: MainMenuDelegate?
    
    var gameIsStart = false
    
    var isMooveCoveyor = true
    
    override func didMove(to view: SKView) {
        configureScene()
        configuredSounds()
        configureNodes()
    }
    
    func configureScene() {
        self.physicsWorld.contactDelegate = self
    }
    
    func configuredSounds() {
        self.addChild(backgroundSound)
        self.addChild(conveyerSound)
        self.addChild(steamSound)
        leverPushSound.autoplayLooped = false
        self.addChild(leverPushSound)
        leverPushSound.run(SKAction.stop())
        let waitFirstAction = SKAction.wait(forDuration:TimeInterval(Int.random(in: 5...8)))
        let block = SKAction.run({ [weak self] in
            if self?.steamVolume == 0 {
                self?.steamVolume = 0.06
                self?.steamSound.run(SKAction.changeVolume(to: 0.06, duration:TimeInterval(Int.random(in: 1...3))))
            } else {
                self?.steamVolume = 0
                self?.steamSound.run(SKAction.changeVolume(to: 0, duration:2))
            }
        })
        let sequence = SKAction.sequence([block, waitFirstAction])
        backgroundSound.run(SKAction.changeVolume(to: 0.18, duration: 0))
        conveyerSound.run(SKAction.changeVolume(to: 0.26, duration: 0))
        steamSound.run(SKAction.changeVolume(to: 0, duration: 0))
        steamSound.run(SKAction.repeatForever(sequence))
    }
    
    func configureNodes() {
        self.rabbitForGenerateConveyor = self.childNode(withName: "rabbitForGenerateConveyor") as? SKSpriteNode
        self.rabbitForGenerateCeiling = self.childNode(withName: "rabbitForGenerateCeiling") as? SKSpriteNode
        self.cageBoxGenerator = self.childNode(withName: "cageBoxGenerator") as? SKSpriteNode
        self.startButton = self.childNode(withName: "cageBoxGenerator")?.childNode(withName: "startButtonContainer") as? SKSpriteNode
        self.cageBoxLever = self.childNode(withName: "cageBoxGenerator")?.childNode(withName: "cageBoxLever") as? SKSpriteNode
        self.cageBoxGenerator.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: cageBoxGenerator.size.height))
        self.cageBoxGenerator.physicsBody?.isDynamic = false
        self.cageBoxGenerator.physicsBody?.categoryBitMask = AppBitMasks.cage
        self.floor = self.childNode(withName: "floor") as? SKSpriteNode
        self.floor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: floor.size.width,
                                                                   height: floor.size.height/3))
        self.floor.physicsBody?.isDynamic = false
        self.floor.physicsBody?.categoryBitMask = AppBitMasks.floor
        self.floor.physicsBody?.restitution = 0
        
        let waitFirstAction = SKAction.wait(forDuration: 1.5)
        let block = SKAction.run({
            self.generateTubeRabbit()
        })
        let sequence = SKAction.sequence([waitFirstAction,block])
        
        run(SKAction.wait(forDuration: 3)) { [weak self] in
            self?.run(.repeatForever(sequence), withKey: "countdown")
        }
        
        let waitSecondAction = SKAction.wait(forDuration: 1.5)
        let block2 = SKAction.run({
            self.generateCeilingRabbit()
        })
        let sequence2 = SKAction.sequence([waitSecondAction,block2])
        
        run(.repeatForever(sequence2), withKey: "countdown2")
        
        runRotateGears()
    }
    
    func runRotateGears() {
        enumerateChildNodes(withName: "gear", using: { node, stop in
            let actionRotate = SKAction.rotate(byAngle: -10, duration: 10)
            let repeatAction = SKAction.repeatForever(actionRotate)
            node.run(repeatAction)
        })
    }
    
    @objc func generateTubeRabbit() {
        let newRabbit = SKSpriteNode(texture: rabbitForGenerateConveyor.texture)
        newRabbit.name = "conveyorRabbit"
        newRabbit.physicsBody = SKPhysicsBody(rectangleOf: rabbitForGenerateConveyor.size)
        newRabbit.position = rabbitForGenerateConveyor.position
        newRabbit.zPosition = rabbitForGenerateConveyor.zPosition
        newRabbit.size = rabbitForGenerateConveyor.size
        newRabbit.physicsBody?.categoryBitMask = AppBitMasks.player
        newRabbit.physicsBody?.contactTestBitMask = AppBitMasks.floor | AppBitMasks.cage
        newRabbit.physicsBody?.allowsRotation = false
        newRabbit.physicsBody?.angularVelocity = 0
        addChild(newRabbit)
    }
    
    @objc func generateCeilingRabbit() {
        let newRabbit = SKSpriteNode(texture: rabbitForGenerateCeiling.texture)
        newRabbit.name = "ceilingRabbit"
        newRabbit.position = rabbitForGenerateCeiling.position
        newRabbit.zPosition = rabbitForGenerateCeiling.zPosition
        newRabbit.size = rabbitForGenerateCeiling.size
        addChild(newRabbit)
        moveCellingRabbit(node: newRabbit)
    }
    
    func mooveGround() {
        let speed: CGFloat = 9
        floor.position.x += speed
        if floor.position.x > 0 {
            floor.position.x -= 50
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let firstTouch = touches.first
        if let touchPoint = firstTouch?.location(in: self) {
            let localNode = self.atPoint(touchPoint)
            actionNode(localNode, touch: firstTouch, touchType: .began)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let firstTouch = touches.first
        if let touchPoint = firstTouch?.location(in: self) {
            let localNode = self.atPoint(touchPoint)
            actionNode(localNode, touch: firstTouch, touchType: .ended)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if isMooveCoveyor {
            mooveGround()
        }
    }
    
    func actionNode(_ node: SKNode, touch: UITouch?, touchType: TouchType) {
       // let spriteNode = node as? SKSpriteNode
        if let nodeName = AciveNodesName(rawValue: node.name ?? "") {
            switch nodeName {
            case .startButton:
                //if !gameIsStart {
                    startButtonSet(touch: touch, touchType: touchType)
                    if touchType == .ended {
                        startGame()
                    }
               // }
            }
        } else {
            if !gameIsStart {
                setButtonDisable(true)
            }
            print("PRESSED UNDEFINED NODE - ", node.name ?? "nil")
        }
    }
    
    func startButtonSet(touch: UITouch?, touchType: TouchType) {
        var isDisable = true
        guard let touchLocation = touch?.location(in: self) else { return }
        if touchType == .began {
            isDisable = false
        } else if touchType == .ended {
            if startButton.contains(touchLocation) {
                isDisable = false
            } else {
                isDisable = true
            }
        }
       setButtonDisable(isDisable)
    }
    
    func setButtonDisable(_ disable: Bool) {
        let newTexture = disable ? SKTexture(image:#imageLiteral(resourceName: "startGameButton")) : SKTexture(image:#imageLiteral(resourceName: "startGameButtonActive"))
        if startButton?.texture != newTexture {
            startButton?.texture = newTexture
        }
    }
    
    func stopGenerateRabbits() {
        removeAction(forKey: "countdown")
        removeAction(forKey: "countdown2")
    }
    
    func pushLever(completion: @escaping()->()) {
        if !isAnimatedCageBoxLever {
            leverPushSound.run(.play())
            conveyerSound.run(SKAction.changeVolume(to: 0.3, duration: 0))
            let rotateAction = SKAction.rotate(toAngle: .pi/4, duration: 0.4)
            isAnimatedCageBoxLever = true
            cageBoxLever.run(rotateAction) { [weak self] in
                let backRotateAction = SKAction.rotate(toAngle: 0, duration: 0.6)
                self?.leverPushSound.run(.play())
                self?.cageBoxLever.run(backRotateAction) { [weak self] in
                    self?.isAnimatedCageBoxLever = false
                    completion()
                }
            }
        }
    }
    
    func startGame() {
        gameIsStart = true
        pushLever() { [weak self] in
            self?.stopGenerateRabbits()
            self?.isMooveCoveyor = false
            self?.mainMenuDelegate?.gameIsStart()
        }
    }

    func moveConveyorRabbit(node: SKNode) {
        let action = SKAction.moveTo(x: (self.size.width + rabbitForGenerateConveyor.size.width), duration: 12)
        let actinonRemove = SKAction.removeFromParent()
        let actiionStay = SKAction(named: "rabbitStayAnimation")!
        node.run(.repeatForever(actiionStay))
        node.run(SKAction.scaleY(to: 0.85, duration: 0.08)) {
            node.run(SKAction.scaleY(to: 1, duration: 0.08))
        }
        node.run(action) {
            node.run(actinonRemove)
        }
    }
    
    func moveCellingRabbit(node: SKNode) {
        let action = SKAction.moveTo(x: 0 - frame.width, duration: 6)
        let actionFly = SKAction(named: "rabbitFlyAnimation")!
        let actinonRemove = SKAction.removeFromParent()
        node.run(.repeatForever(actionFly))
        node.run(action) {
            node.run(actinonRemove)
        }
    }
    
    func addedCageToRabbit(node: SKNode) {
        if let rabbit = node as? SKSpriteNode {
            let actiionGage = SKAction(named: "rabbitCageAnimation")!
            rabbit.run(.repeatForever(actiionGage))
            rabbit.size = CGSize(width: 186, height: 143)
        }
    }
}

extension MainMenuScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let nodeB = contact.bodyB.node {
            if nodeB.name == "conveyorRabbit" {
                nodeB.physicsBody?.contactTestBitMask = AppBitMasks.cage
                moveConveyorRabbit(node: nodeB)
            }
        }
        if contact.bodyA.node?.name == "cageBoxGenerator"  {
            if let nodeB = contact.bodyB.node {
                addedCageToRabbit(node: nodeB)
                nodeB.physicsBody = nil
            }
        }
    }
}
