//
//  MarketGardenScene.swift
//  Focus
//
//  Created by Igor Starobor on 24.05.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit
import GameplayKit

class MarketGardenScene: SKScene {
    
    override func didMove(to view: SKView) {
        configureScene()
        configureNodes()
    }
    
    func configureScene() {
        self.physicsWorld.contactDelegate = self
    }
    
    func configureNodes() {
       
    }

    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
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

extension MarketGardenScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
}
