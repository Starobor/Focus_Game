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
import SnapKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuredSKView()
        setMainMenuScene()
        
       
        
    /*  let dialog = DialogView()
        dialog.tag = 1002
        self.view.addSubview(dialog)
        dialog.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(120)
            make.trailing.equalTo(-120)
            make.bottom.equalTo(-20)
            make.height.equalTo(80)
        }*/
    }
    
    func setSceneType<T: BaseMapScene>(_ type: T.Type) {
        print("set scene as: \(type)")
        if let scene = GKScene(fileNamed: "\(T.self)")   {
            if let sceneNode = scene.rootNode as! T? {
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                skView.presentScene(sceneNode)
            }
        }
    }
    
    // Load the SKScene from 'MainMenuScene.sks'
    func setMainMenuScene() {
        if let scene = SKScene(fileNamed: "MainMenuScene") as? MainMenuScene {
            scene.scaleMode = .aspectFill
            scene.mainMenuDelegate = self
            skView.presentScene(scene)
        }
    }
    
    func configuredSKView() {
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.preferredFramesPerSecond = 30
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

extension GameViewController: MainMenuDelegate {
    func gameIsStart() {
        //setSceneType(FarmScene.self)
        let gamblingVC = GamblingViewController()
        gamblingVC.modalPresentationStyle = .overFullScreen
        present(gamblingVC, animated: true)
    }
}
