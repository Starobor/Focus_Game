//
//  AppBitMasks.swift
//  Focus
//
//  Created by Igor Starobor on 25.02.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import Foundation

final class AppBitMasks {
    
    static let shared = AppBitMasks()
    
    static let player: UInt32 = 0b01
    static let floor: UInt32 = 0b10
    static let cage: UInt32 = 0b100
    private init() {
        
    }

}
