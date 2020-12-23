//
//  PlayerInteractableButtonsComponent.swift
//  Focus
//
//  Created by Igor Starobor on 07.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol PlayerInteractableDelegatet: class {
    func follow(command: PlayerInteractableButtonsComponent.InteractableButtonsCommand)
}

class PlayerInteractableButtonsComponent: GKComponent, InteractableActionButtonsDelegate {
    
    override class var supportsSecureCoding: Bool {
        return true
    }
    
    enum InteractableButtonsCommand: String {
        case pressedTalk = "stop talk"
        case pressedAction = "stop action"
        case pressedGame = "stop game"
    }
    
    var actionButtonslNode: InteractableMainHeroButtons?
    var cNode: MainCharacter?
    
    weak var delegate: PlayerInteractableDelegatet?
    var previousComand = ""
    
    func setupControls(camera: SKCameraNode, scene: SKScene) {
        if cNode != nil {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                cNode = nodeComponent.node as? MainCharacter
            }
            actionButtonslNode = InteractableMainHeroButtons(frame: scene.frame)
            actionButtonslNode!.inputDelegate = self
            actionButtonslNode!.position = .zero
            camera.addChild(actionButtonslNode!)
        }
    }
    
    func follow(command: String?) {
        guard let command = command else { return }
        if cNode != nil {
            if command.contains("stop") {
                if "stop \(previousComand)" == command {
                    if let pressedButonCommand = InteractableButtonsCommand(rawValue: command) {
                        delegate?.follow(command: pressedButonCommand)
                        print("pressed: \(String(describing: previousComand)) button")
                    } else {
                        print("command: \(command) undefind")
                    }
                }
            }
        }
        previousComand = command
    }
    
    
}
