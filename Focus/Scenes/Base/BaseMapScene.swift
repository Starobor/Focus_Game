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

class BaseMapScene: SKScene {
    
    var entities: [GKEntity] = []
    var graphs: [String : GKGraph] = [:]
    
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
        configureScene()
        configureNodes()
        mainHero.setUpStateMachine()
        
        if let pcComponent = mainHero.entity?.component(ofType: PlayerControlComponent.self) {
            pcComponent.cNode = mainHero
            pcComponent.setupControls(camera: camera!, scene: self)
            pcComponent.delegate = self
        }
        
        if let anComponent = mainHero.entity?.component(ofType: AnimateComponent.self) {
            anComponent.cNode = mainHero
        }
        
        if let inbComponent = mainHero.entity?.component(ofType: PlayerInteractableButtonsComponent.self) {
            inbComponent.cNode = mainHero
            inbComponent.delegate = self
            inbComponent.setupControls(camera: camera!, scene: self)
            inbComponent.actionButtonslNode?.isHidden = selectedHero == nil
        }
    }
    
    override func didSimulatePhysics() {
        self.mainCamera.position = CGPoint(x: mainHero.position.x, y: mainHero.position.y)
    }
    
    func configureScene() {
        self.physicsWorld.contactDelegate = self
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
        let screenBounds = UIScreen.main.bounds
        let screenScale = UIScreen.main.scale
        let screenSize = CGSize(width: screenBounds.size.width * screenScale, height: screenBounds.size.height * screenScale)
        print(screenSize)
        mainCamera.setScale(2)
        self.addChild(mainCamera)
        self.camera = mainCamera
        
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
    
}

extension BaseMapScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}

extension BaseMapScene: PlayerControlDelegate {
    
    func follow(command: PlayerControlComponent.PlayerControlCommand) {
        if let inbComponent = mainHero.entity?.component(ofType: PlayerInteractableButtonsComponent.self) {
            selectedHero = nil
            inbComponent.actionButtonslNode?.isHidden = true
        }
    }
}

extension BaseMapScene: PlayerInteractableDelegatet {
    
    func follow(command: PlayerInteractableButtonsComponent.InteractableButtonsCommand) {
        
    }
    
}
