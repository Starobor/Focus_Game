//
//  WaterWellScene.swift
//  Focus
//
//  Created by Igor Starobor on 24.05.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVKit

class WaterWellScene: SKScene {
    
    var timer = Timer()
    var data = (SKAction, SKNode).self
    
    override func didMove(to view: SKView) {
        configureScene()
        configureNodes()
    }
    
    func configureScene() {
        self.physicsWorld.contactDelegate = self
    }
    
    func configureNodes() {
        let load = loadData(scene: scene!)
        if load.0 {
            configureNodes()
        }
    }
    
    
    func loadData(scene: SKScene) -> (Bool, String){
        
        var loadStatus:(Bool, String) = (true, "No errors")
        
        //mainScene = scene
        
        // play background music
        let backgroundSound = AVPlayer(url: URL(string: "farmBacground.mp3")!)
        backgroundSound.play()
           
        return loadStatus
    }
    
    
    private func updateGameState(){
        guard let mainscene = self.scene else{
            print ("ERROR D00: Check updateGameState() from GameInfo")
            return
        }
        
        switch mainscene.scaleMode {
        case .fill:
            
            // Load Map
           
            
            // Cloud action
            let moveDownCloud = SKAction.moveTo(y: 23, duration: 1)
            
            // Buildings Action
            let scaleAction = SKAction.scale(to: 0.7, duration: 0.3)
            let moveAction = SKAction.moveTo(y: 20, duration: 0.3)
            let buildingsAction = SKAction.sequence([SKAction.run(SKAction.group([scaleAction, moveAction]), onChildWithName: "main_menu_middle_root"), SKAction.wait(forDuration: 1.5), SKAction.run {
                let n = self.childNode(withName: "main_menu_middle")!.childNode(withName: "main_menu_middle_root")
                n!.childNode(withName: "Global.Main.Main_Menu_Background_1.rawValue")!.removeFromParent()
                n!.childNode(withName: "Global.Main.Main_Menu_Background_2.rawValue")!.removeFromParent()
                n!.childNode(withName: "Global.Main.Main_Menu_Background_3.rawValue")!.removeFromParent()
                n!.run(scaleAction)
                
                }])
            
        // Create 4 clouds
        case .aspectFill:
            for i in 0...3{
                let cloud = SKSpriteNode()
                if ( i % 2 == 0){
                    cloud.texture = SKTexture(image: UIImage(named: "cell1.png")!)
                    cloud.name = "rabbit"
                }
                else{
                    cloud.texture = SKTexture(image: UIImage(named: "cell4.png")!)
                    cloud.name = "rabbit"
                }
                cloud.anchorPoint = CGPoint(x: 0.5, y: 0)
                cloud.zPosition = -1
                mainscene.addChild(cloud)
            }
            
            // Running Actions
            
            
            
        case .aspectFit:
            mainscene.run(SKAction.sequence([ SKAction.wait(forDuration: 3), SKAction.run{
                }, SKAction.wait(forDuration: 0.2), SKAction.run { self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
                    
                    self.addChild(SKNode())
                    }, SKAction.wait(forDuration: 0.06)])))
                }]))
            
        case .resizeFill:
            
            let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(flash), userInfo: nil, repeats: true)
            
            let wavesForNextLevel = 3
            
            let action = SKAction.sequence([SKAction.run({

            }), SKAction.wait(forDuration: 3)])
            
            //totalWaves
            //wavesForNextLevel
            let spawnAction = SKAction.repeat(action, count: wavesForNextLevel)
            let endAction = SKAction.run({})
            
            mainscene.run(SKAction.sequence([spawnAction, endAction]))
            
            // use this state to cancel the timer - invalidate
            print("Boss Encounter")
            timer.invalidate()
        @unknown default:
            ()
        }
    }

    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    
    func load(scene: SKScene) -> (Bool, String){
        
        var loadStatus:(Bool, String) = (true, "No errors")
        
        //mainScene = scene
        
        // play background music
        let backgroundSound = AVPlayer(url: URL(string: "farmBacground.mp3")!)
        backgroundSound.play()
        
        return loadStatus
    }
    
    
    private func updateGameStateLoad(){
        guard let mainscene = self.scene else{
            print ("ERROR D00: Check updateGameState() from GameInfo")
            return
        }
        
        switch mainscene.scaleMode {
        case .fill:
            
            // Load Map
           
            
            // Cloud action
            let moveDownCloud = SKAction.moveTo(y: 23, duration: 1)
            
            // Buildings Action
            let scaleAction = SKAction.scale(to: 0.7, duration: 0.3)
            let moveAction = SKAction.moveTo(y: 20, duration: 0.3)
            let buildingsAction = SKAction.sequence([SKAction.run(SKAction.group([scaleAction, moveAction]), onChildWithName: "main_menu_middle_root"), SKAction.wait(forDuration: 1.5), SKAction.run {
                let n = self.childNode(withName: "main_menu_middle")!.childNode(withName: "main_menu_middle_root")
                n!.childNode(withName: "Global.Main.Main_Menu_Background_1.rawValue")!.removeFromParent()
                n!.childNode(withName: "Global.Main.Main_Menu_Background_2.rawValue")!.removeFromParent()
                n!.childNode(withName: "Global.Main.Main_Menu_Background_3.rawValue")!.removeFromParent()
                n!.run(scaleAction)
                
                }])
            
        // Create 4 clouds
        case .aspectFill:
            for i in 0...3{
                let cloud = SKSpriteNode()
                if ( i % 2 == 0){
                    cloud.texture = SKTexture(image: UIImage(named: "cell1.png")!)
                    cloud.name = "rabbit"
                }
                else{
                    cloud.texture = SKTexture(image: UIImage(named: "cell4.png")!)
                    cloud.name = "rabbit"
                }
                cloud.anchorPoint = CGPoint(x: 0.5, y: 0)
                cloud.zPosition = -1
                mainscene.addChild(cloud)
            }
            
            // Running Actions
            
            
            
        case .aspectFit:
            mainscene.run(SKAction.sequence([ SKAction.wait(forDuration: 3), SKAction.run{
                }, SKAction.wait(forDuration: 0.2), SKAction.run { self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
                    
                    self.addChild(SKNode())
                    }, SKAction.wait(forDuration: 0.06)])))
                }]))
            
        case .resizeFill:
            
            let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(flash), userInfo: nil, repeats: true)
            
            let wavesForNextLevel = 3
            
            let action = SKAction.sequence([SKAction.run({

            }), SKAction.wait(forDuration: 3)])
            
            //totalWaves
            //wavesForNextLevel
            let spawnAction = SKAction.repeat(action, count: wavesForNextLevel)
            let endAction = SKAction.run({})
            
            mainscene.run(SKAction.sequence([spawnAction, endAction]))
            
            // use this state to cancel the timer - invalidate
            print("Boss Encounter")
            timer.invalidate()
        @unknown default:
            ()
        }
    }
    
    @objc func flash() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
     
    }
    
}

extension WaterWellScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}
