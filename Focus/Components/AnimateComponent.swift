//
//  AnimateComponent.swift
//  Focus
//
//  Created by Igor Starobor on 04.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit
import GameplayKit

class AnimateComponent: GKComponent {
    
    override class var supportsSecureCoding: Bool {
        return true
    }
    
    var cNode: MainCharacter?
    
    var leftRunAnimation: SKAction?
    var rightRunAnimation: SKAction?
    var leftWaitAnimation: SKAction?
    var rightWaitAnimation: SKAction?
    
    override init() {
        super.init()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupActions()
    }
    
    func setupActions() {
        leftRunAnimation = SKAction(named: "moveLeft")
        rightRunAnimation = SKAction(named: "moveRight")
        leftWaitAnimation = SKAction(named: "stayLeft")
        rightWaitAnimation = SKAction(named: "stayRight")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if cNode != nil {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                cNode = nodeComponent.node as? MainCharacter
            }
            
            if cNode!.stateMachine?.currentState is  NormalState {
                switch cNode!.playerState {
                case .moveLeft, .moveRight:
                    let action = cNode!.playerState == .moveLeft ? leftRunAnimation : rightRunAnimation
                    if cNode?.action(forKey: "walk") == nil {
                        cNode?.removeAllActions()
                        cNode?.run(action!, withKey: "walk")
                    }
                case .stopLeft, .stopRight:
                    let action = cNode!.playerState == .stopLeft ? leftWaitAnimation : rightWaitAnimation
                    if cNode?.action(forKey: "stop") == nil {
                        cNode?.removeAllActions()
                        cNode?.run(action!, withKey: "stop")
                    }
                }
                
            }
        }
    }
}
