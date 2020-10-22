//
//  SettingsButton.swift
//  Focus
//
//  Created by Igor Starobor on 15.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit

protocol SettingsButtonDelegate: class {
    func follow(command: String?)
}

class SettingsButton: BaseControllNode {
    
    let settingsButton  = SKSpriteNode(imageNamed: "menuSettings")
    
    weak var inputDelegate: SettingsButtonDelegate?
    
    init(frame: CGRect) {
        super.init(texture: nil, color: .clear, size: CGSize(width: frame.width, height: 0))
        self.isUserInteractionEnabled = true
        setupCntrollers(size: frame.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCntrollers(size: CGSize) {
        addButton(button: settingsButton,
                  position: CGPoint(x: size.width/2 - 50,
                                    y: size.height/2 - 50),
                  name: "settings")
        allButtons = [settingsButton]
    }
    
    func addButton(button: SKSpriteNode, position: CGPoint, name: String) {
        button.size = CGSize(width: 50, height: 50)
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
