//
//  FarmScene.swift
//  Focus
//
//  Created by Igor Starobor on 24.05.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVKit
import RxRelay

class FarmScene: BaseMapScene {
    
    private var rabbitWalkingFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
     
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
    }
    
    override func touchDown(atPoint pos : CGPoint) {
        super.touchDown(atPoint: pos)
        
    }
    
    override func touchMoved(toPoint pos : CGPoint) {
        super.touchMoved(toPoint: pos)
        
    }
    
    override func touchUp(atPoint pos : CGPoint) {
        super.touchUp(atPoint: pos)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
    }

    override func pressedHero(node: BaseHero) {
        print(node.helloSentence)
    }
    
    override func follow(command: PlayerControlComponent.PlayerControlCommand) {
        super.follow(command: command)
    }
    
}
