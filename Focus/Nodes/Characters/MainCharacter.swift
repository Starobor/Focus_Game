//
//  MainCharacter.swift
//  Focus
//
//  Created by Igor Starobor on 10.09.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit
import GameplayKit

class MainCharacter: BaseHero {
   
    enum PlayerState {
        case moveLeft
        case moveRight
        case stopLeft
        case stopRight
    }
   
    var hSpeed: CGFloat = 0
    var walkSpeed: CGFloat = 6
    
    var stateMachine: GKStateMachine?
    var playerState: PlayerState =  .stopRight
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setUpStateMachine() {
        let normalState = NormalState(with: self)
        stateMachine = GKStateMachine(states: [normalState])
        stateMachine?.enter(NormalState.self)
    }
    
    func interactableButtonsSet(hide: Bool) {
        if hide {
            
        }
    }
    
    func addInteractableButton(name: String) {
        let button = SKSpriteNode();
        button.size = CGSize(width: 100, height: 100)
        button.position = CGPoint(x: 0, y: 0)
        button.name = name
        button.zPosition = 10
        addChild(button)
    }

}
