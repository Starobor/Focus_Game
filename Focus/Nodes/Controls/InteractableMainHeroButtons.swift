//
//  InteractableMainHeroButtons.swift
//  Focus
//
//  Created by Igor Starobor on 07.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit

protocol InteractableActionButtonsDelegate: class {
    func follow(command: String?)
}

class InteractableMainHeroButtons: BaseControllNode {
    
    let talkButton  = SKSpriteNode(imageNamed: "talkButton")
    let actionButton = SKSpriteNode(imageNamed: "actionButton")
    let gameButton = SKSpriteNode(imageNamed: "gameButton")
    
    weak var inputDelegate: InteractableActionButtonsDelegate?
    
    init(frame: CGRect) {
        super.init(texture: nil, color: .clear, size: CGSize(width: frame.width, height: 0))
        self.isUserInteractionEnabled = true
        setupCntrollers(size: frame.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func setupCntrollers(size: CGSize) {
        addButton(button: talkButton,
                  position: CGPoint(x: -100,
                                    y: -size.height/2 + 55),
                  name: "talk")
        addButton(button: actionButton,
                  position: CGPoint(x:  0,
                                    y: -size.height/2 + 55),
                  name: "action")
        addButton(button: gameButton,
                  position: CGPoint(x:  100,
                                    y: -size.height/2 + 55),
                  name: "game")
        allButtons = [talkButton, actionButton, gameButton]
    }
    
    func addButton(button: SKSpriteNode, position: CGPoint, name: String) {
        button.size = CGSize(width: 70, height: 70)
        button.position = position
        button.name = name
        button.zPosition = 10
        button.alpha = alphaPressed
        addChild(button)
    }
    
    override func follow(command: String) {
        if (inputDelegate != nil) {
            inputDelegate?.follow(command: command)
        }
    }
}
