//
//  HorseCharacter.swift
//  Focus
//
//  Created by Igor Starobor on 06.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit

class HorseCharacter: BaseHero {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        prepareValues()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareValues()
    }
    
    func prepareValues() {
        helloSentence = "Hello, I'm horse"
    }
    
}

