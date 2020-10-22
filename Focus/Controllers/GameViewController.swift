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
    
    var players = HorseRacingDataPreparer(data: HorseRacingData())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuredSKView()
        setMainMenuScene()
        
        
        let gambling = HorseRacingData()
        print(gambling.horseRacingGambling)
        
        
        
      //let dialog = DialogView()
      //  dialog.tag = 1002
      //  self.view.addSubview(dialog)
      //  dialog.snp.makeConstraints { (make) -> Void in
      //      make.leading.equalTo(120)
      //      make.trailing.equalTo(-120)
      //      make.bottom.equalTo(-15)
      //      make.height.equalTo(80)
      //  }
    }
    
    func setSceneType<T: BaseMapScene>(_ type: T.Type) {
        print("set scene as: \(type)")
        if let scene = GKScene(fileNamed: "\(T.self)")   {
            if let sceneNode = scene.rootNode as! T? {
                sceneNode.baseSceneDelegate = self
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
        setSceneType(FarmScene.self)
       // let gamblingVC = GamblingViewController(data: players)
       // gamblingVC.delegate = self
       // gamblingVC.modalPresentationStyle = .overFullScreen
       // present(gamblingVC, animated: true)
    }
}

extension GameViewController: GamblingViewDelegate {
    func selected(index: Int) {
        let model = HorseRacingCML()
        print(index)
        let selectedPlayer = players.data.horses[index]
        for (horseIndex, horse) in players.data.horses.enumerated() {
            guard let horsesOutput = try? model.prediction(hSp: horse.hSp, hAg: horse.hAg, hWe: horse.hWe, hSt: Double(horse.hSt?.rawValue ?? 0), hEx: horse.hEx, rAg: horse.rAg, rWe: horse.rWe, rEx: horse.rEx, rSt: Double(horse.rSt!.rawValue), rFi: horse.rFi, gDi: horse.gDi, gWe: horse.gWe, gTr: horse.gTr, gTi: horse.gTi, tDi: players.data.map.tDi, tWe: players.data.map.tWe, tTr: players.data.map.tTr, tTi: players.data.map.tTi) else {
                fatalError("Unexpected runtime error.")
            }
            players.data.horses[horseIndex].viktories = Int(horsesOutput.victories)
            print(players.data.horses[horseIndex].viktories ?? "")
        }
        
        let winer = players.data.horses.max(by: {$0.viktories ?? 0 < $1.viktories ?? 0})
        if winer?.id == selectedPlayer.id {
            print("Wiin")
        }
        print("w",winer?.viktories ?? "")
        
    }
}

extension GameViewController: BaseMapSceneDelegate {
    func didPressedSettings() {
        setMainMenuScene()
    }
    
    
}

