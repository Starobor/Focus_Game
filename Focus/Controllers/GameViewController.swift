//
//  GameViewController.swift
//  Focus
//
//  Created by Igor Starobor on 15.02.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuredSKView()
        setMainMenuScene()
    }
    
    // Load the SKScene from 'MainMenuScene.sks'
    func setMainMenuScene() {
        if let scene = SKScene(fileNamed: "MainMenuScene") {
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
        }
    }
    
    func setFarmScene() {
           if let scene = SKScene(fileNamed: "FarmScene") {
               skView.presentScene(scene)
           }
       }
    
    func configuredSKView() {
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
