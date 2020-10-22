//
//  BaseControllNode.swift
//  Focus
//
//  Created by Igor Starobor on 15.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit

class BaseControllNode: SKSpriteNode {
    
    var alphaUnpressed: CGFloat = 0.5
    var alphaPressed: CGFloat   = 0.9
    
    var pressedButtons: [SKSpriteNode] = []
    var allButtons: [SKSpriteNode] = []
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: parent!)
            
            for button in allButtons {
                
                if button.contains(location) && pressedButtons.firstIndex(of: button) == nil {
                    pressedButtons.append(button)
                    follow(command: button.name ?? "UNKNOWN")
                }
                
                button.alpha = pressedButtons.firstIndex(of: button) == nil ? alphaPressed : alphaUnpressed
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: parent!)
            let previousLocation = touch.previousLocation(in: parent!)
            
            for button in allButtons {
                if button.contains(previousLocation) && !button.contains(location){
                    let index = pressedButtons.firstIndex(of: button)
                    
                    if index != nil {
                        pressedButtons.remove(at: index!)
                        follow(command: "cancele \(button.name ?? "UNKNOWN")")
                    }
                    
                } else if !button.contains(previousLocation) && button.contains(location) && pressedButtons.firstIndex(of: button) == nil {
                    pressedButtons.append(button)
                    follow(command: button.name ?? "UNKNOWN")
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
            
            for button in allButtons {
                if button.contains(location) || button.contains(previousLocation) {
                    let index = pressedButtons.firstIndex(of: button)
                    if index != nil {
                        pressedButtons.remove(at: index!)
                        follow(command: "stop \(button.name ?? "unknown")")
                    }
                }
                button.alpha = pressedButtons.firstIndex(of: button) == nil ? alphaPressed : alphaUnpressed
            }
        }
    }
    
    func follow(command: String) {
        
    }   
    
}
