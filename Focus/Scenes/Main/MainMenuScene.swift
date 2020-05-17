//
//  MainMenuScene.swift
//  Focus
//
//  Created by Igor Starobor on 15.02.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit
import GameplayKit

class MainMenuScene: SKScene {
    
    private var rabbitForGenerateConveyor: SKSpriteNode!
    private var rabbitForGenerateCeiling: SKSpriteNode!
    private var cageBoxGenerator: SKSpriteNode!
    private var floor: SKSpriteNode!
    
    private var isNeedGenerateRebit = true
    var timerRabbitTube = Timer()
    var timerRabbitСeiling = Timer()
    
    
    override func didMove(to view: SKView) {
        configureScene()
        configureNodes()
    }
    
    func configureScene() {
        self.physicsWorld.contactDelegate = self
    }
    
    func configureNodes() {
        self.rabbitForGenerateConveyor = self.childNode(withName: "rabbitForGenerateConveyor") as? SKSpriteNode
        self.rabbitForGenerateCeiling = self.childNode(withName: "rabbitForGenerateCeiling") as? SKSpriteNode
        self.cageBoxGenerator = self.childNode(withName: "cageBoxGenerator") as? SKSpriteNode
        self.cageBoxGenerator.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: cageBoxGenerator.size.height))
        self.cageBoxGenerator.physicsBody?.isDynamic = false
        self.cageBoxGenerator.physicsBody?.categoryBitMask = AppBitMasks.cage
        self.floor = self.childNode(withName: "floor") as? SKSpriteNode
        self.floor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: floor.size.width,
                                                                   height: floor.size.height/3))
        self.floor.physicsBody?.isDynamic = false
        self.floor.physicsBody?.categoryBitMask = AppBitMasks.floor
        self.timerRabbitTube = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.generateTubeRabbit), userInfo: nil, repeats: true)
        self.timerRabbitСeiling = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.generateCeilingRabbit), userInfo: nil, repeats: true)
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
        let speed: CGFloat = 5
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
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        mooveGround()
    }
    
    
    func moveConveyorRabbit(node: SKNode) {
        let action = SKAction.moveTo(x: (self.size.width + rabbitForGenerateConveyor.size.width), duration: 6)
        let actinonRemove = SKAction.removeFromParent()
        node.run(action) {
            node.run(actinonRemove)
        }
    }
    
    func moveCellingRabbit(node: SKNode) {
        let action = SKAction.moveTo(x: 0 - frame.width, duration: 4)
        let actinonRemove = SKAction.removeFromParent()
        node.run(action) {
            node.run(actinonRemove)
        }
    }
    
    func addedCageToRabbit(node: SKNode) {
        if let rabbit = node as? SKSpriteNode {
            rabbit.size = CGSize(width: 176, height: 168)
            rabbit.texture = SKTexture(image: #imageLiteral(resourceName: "cageRabbit"))
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
