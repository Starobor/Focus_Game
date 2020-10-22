//
//  TouchControlInput.swift
//  Focus
//
//  Created by Igor Starobor on 03.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit

protocol ControllerInputDelegate: class {
    func follow(command: String?)
}

class TouchControlInput: BaseControllNode {
    
    let leftButton  = SKSpriteNode(imageNamed: "leftMoveButton")
    let rightButton = SKSpriteNode(imageNamed: "rightMoveButton")
    
    weak var inputDelegate: ControllerInputDelegate?
    
    init(frame: CGRect) {
        super.init(texture: nil, color: .clear, size: CGSize(width: frame.width, height: 0))
        self.isUserInteractionEnabled = true
        setupCntrollers(size: frame.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCntrollers(size: CGSize) {
        addButton(button: leftButton,
                  position: CGPoint(x: -size.width/2 + 65,
                                    y: -size.height/2 + 55),
                  name: "left")
        addButton(button: rightButton,
                  position: CGPoint(x:  size.width/2 - 65,
                                    y: -size.height/2 + 55),
                  name: "right")
        allButtons = [leftButton, rightButton]
    }
    
    func addButton(button: SKSpriteNode, position: CGPoint, name: String) {
        button.size = CGSize(width: 80, height: 80)
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
