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

class InteractableMainHeroButtons: SKSpriteNode {
    
    var alphaUnpressed: CGFloat = 0.5
    var alphaPressed: CGFloat   = 0.9
    
    var pressedButtons: [SKSpriteNode] = []
    
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
                                    y: -size.height/2 + 70),
                  name: "talk")
        addButton(button: actionButton,
                  position: CGPoint(x:  0,
                                    y: -size.height/2 + 70),
                  name: "action")
        addButton(button: gameButton,
                  position: CGPoint(x:  100,
                                    y: -size.height/2 + 70),
                  name: "game")
    }
    
    func addButton(button: SKSpriteNode, position: CGPoint, name: String) {
        button.size = CGSize(width: 80, height: 80)
        button.position = position
        button.name = name
        button.zPosition = 10
        button.alpha = alphaPressed
        addChild(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: parent!)
            
            for button in [talkButton, actionButton, gameButton] {
                
                if button.contains(location) && pressedButtons.firstIndex(of: button) == nil {
                    pressedButtons.append(button)
                    if (inputDelegate != nil) {
                        inputDelegate?.follow(command: button.name)
                    }
                }
                
                button.alpha = pressedButtons.firstIndex(of: button) == nil ? alphaPressed : alphaUnpressed
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: parent!)
            let previousLocation = touch.previousLocation(in: parent!)
            
            for button in [talkButton, actionButton, gameButton] {
                if button.contains(previousLocation) && !button.contains(location){
                    let index = pressedButtons.firstIndex(of: button)
                    
                    if index != nil {
                        pressedButtons.remove(at: index!)
                        if (inputDelegate != nil) {
                            inputDelegate?.follow(command: "cancele  \(button.name ?? "unknown")")
                        }
                    }
                    
                } else if !button.contains(previousLocation) && button.contains(location) && pressedButtons.firstIndex(of: button) == nil {
                    pressedButtons.append(button)
                    if (inputDelegate != nil) {
                        inputDelegate?.follow(command: button.name)
                    }
                }
                
                button.alpha = pressedButtons.firstIndex(of: button) == nil ? alphaPressed : alphaUnpressed
                
                
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchUp(touches: touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchUp(touches: touches, with: event)
    }
    
    func touchUp(touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: parent!)
            let previousLocation = touch.previousLocation(in: parent!)
            
            for button in [talkButton, actionButton, gameButton] {
                if button.contains(location) || button.contains(previousLocation) {
                    let index = pressedButtons.firstIndex(of: button)
                    if index != nil {
                        pressedButtons.remove(at: index!)
                        
                        if inputDelegate != nil  {
                            inputDelegate?.follow(command: "stop \(button.name ?? "unknown")")
                        }
                    }
                }
                button.alpha = pressedButtons.firstIndex(of: button) == nil ? alphaPressed : alphaUnpressed
            }
        }
    }

}
