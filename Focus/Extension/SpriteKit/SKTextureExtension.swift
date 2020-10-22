//
//  SKTextureExtension.swift
//  Focus
//
//  Created by Igor Starobor on 31.07.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import Foundation
import SpriteKit

extension SKTexture {
    var name:String? {
        let comps = description.components(separatedBy: "'")
        return comps.count > 1 ? comps[1] : nil
    }
}
