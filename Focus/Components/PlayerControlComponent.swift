//
//  PlayerControlComponent.swift
//  Focus
//
//  Created by Igor Starobor on 03.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol PlayerControlDelegate: class {
    func follow(command: PlayerControlComponent.PlayerControlCommand)
}

class PlayerControlComponent: GKComponent, ControllerInputDelegate {
    
    override class var supportsSecureCoding: Bool {
        return true
    }
    
    enum PlayerControlCommand: String {
        case left = "left"
        case stopLeft = "stop left"
        case canceleLeft = "cancele left"
        case right = "right"
        case stopRight = "stop right"
        case canceleRight = "cancele right"
    }
    
    var touchControlNode: TouchControlInput?
    var cNode: MainCharacter?
    
    weak var delegate: PlayerControlDelegate?
    
    func setupControls(camera: SKCameraNode, scene: SKScene) {
        touchControlNode = TouchControlInput(frame: scene.frame)
        touchControlNode?.inputDelegate = self
        touchControlNode?.position = .zero
        camera.addChild(touchControlNode!)
        
        if cNode != nil {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                cNode = nodeComponent.node as? MainCharacter
            }
            
        }
    }
    
    func follow(command: String?) {
        if cNode != nil {
            if let command = PlayerControlCommand(rawValue: command ?? "") {
                switch command {
                case .left:
                    cNode?.playerState = .moveLeft
                case .stopLeft, .canceleLeft:
                    cNode?.playerState = .stopLeft
                case .right:
                    cNode?.playerState = .moveRight
                case .stopRight, .canceleRight:
                    cNode?.playerState = .stopRight
                }
                delegate?.follow(command: command)
                print("command: \(command.rawValue)")
            } else {
                print("command: \(command ?? "UNKNOWN") undefind")
            }
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        cNode?.stateMachine?.update(deltaTime: seconds)
    }
    
}
