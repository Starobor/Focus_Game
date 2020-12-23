//
//  CowCharacter.swift
//  Focus
//
//  Created by Igor Starobor on 13.12.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import SpriteKit

class CowCharacter: BaseHero {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        prepareValues()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareValues()
    }
    
    func prepareValues() {
        helloSentence = "Hello, I'm cow"
    }
    
}
