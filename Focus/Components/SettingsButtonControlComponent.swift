//
//  SettingsButtonControlComponent.swift
//  Focus
//
//  Created by Igor Starobor on 15.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol SettingsButtonControlDelegatet: class {
    func didPressedButton()
}

class SettingsButtonControlComponent: GKComponent, SettingsButtonDelegate {
    
    override class var supportsSecureCoding: Bool {
        return true
    }
    
    var settingsButton: SettingsButton?
    var cNode: MainCharacter?
    
    weak var delegate: SettingsButtonControlDelegatet?
    var previousComand = ""
    
    func setupControls(camera: SKCameraNode, scene: SKScene) {
        if cNode != nil {
            if let nodeComponent = self.entity?.component(ofType: GKSKNodeComponent.self) {
                cNode = nodeComponent.node as? MainCharacter
            }
            settingsButton = SettingsButton(frame: scene.frame)
            settingsButton!.inputDelegate = self
            settingsButton!.position = .zero
            camera.addChild(settingsButton!)
        }
    }
    
    func follow(command: String?) {
        guard let command = command else { return }
        if cNode != nil {
            if command.contains("stop") {
                if "stop \(previousComand)" == command {
                    delegate?.didPressedButton()
                }
            }
        }
        previousComand = command
    }
    
    
}
