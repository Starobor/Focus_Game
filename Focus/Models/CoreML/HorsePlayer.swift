//
//  HorsePlayer.swift
//  Focus
//
//  Created by Igor Starobor on 15.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import Foundation

struct HorsePlayer {
   
    let hSpeed = Double(Int.random(in: 50 ... 65))
    let hAge = Double(Int.random(in: 4 ... 18))
    let hWeight = Double(Int.random(in: 400 ... 600))
    let hState = State.allCases.randomElement()
    let hExperience = Double(Int.random(in: 2 ... 9))
    
    let rAge = Double(Int.random(in: 12 ... 30))
    let rWeight = Double(Int.random(in: 40 ... 65))
    let rExperience = Double(Int.random(in: 1 ... 10))
    let rState = State.allCases.randomElement()
    let rFinancialCondition = Double(Int.random(in: 1 ... 3))
    
    let tDistance = Double(Int.random(in: 2 ... 5))
    
    enum State: Int, CaseIterable {
        case awful = -4
        case bad = -2
        case normal = 1
        case good = 2
        case perfect = 3
    }

}
