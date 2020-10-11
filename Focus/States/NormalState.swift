//
//  NormalState.swift
//  Focus
//
//  Created by Igor Starobor on 02.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import GameplayKit

class NormalState: GKState {
    
    var cNode: MainCharacter
    
    init(with node: MainCharacter) {
        cNode = node
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        switch cNode.playerState {
        case .moveLeft:
            cNode.hSpeed = -cNode.walkSpeed
        case .moveRight:
            cNode.hSpeed = cNode.walkSpeed
        case .stopLeft, .stopRight:
            cNode.hSpeed = 0
        }
        cNode.position.x += cNode.hSpeed
        
    }
    
}

