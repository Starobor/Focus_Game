//
//  HorsePlayer.swift
//  Focus
//
//  Created by Igor Starobor on 15.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import Foundation

class HorseRacingPlayer: BasePlayerLocalizeDescription {
    let id = UUID().uuidString
    var hSp = Double(Int.random(in: 50 ... 65))
    var hAg = Double(Int.random(in: 4 ... 18))
    var hWe = Double(Int.random(in: 400 ... 600))
    var hSt = State.allCases.randomElement()
    var hEx = Double(Int.random(in: 2 ... 9))
    var rAg = Double(Int.random(in: 12 ... 30))
    var rWe = Double(Int.random(in: 40 ... 65))
    var rEx = Double(Int.random(in: 1 ... 10))
    var rSt = State.allCases.randomElement()
    var rFi = Double(Int.random(in: 1 ... 3))
    var gDi = Double(Int.random(in: 1 ... 3))
    var gWe = Double(Int.random(in: 1 ... 4))
    var gTr = Double(Int.random(in: 1 ... 4))
    var gTi = Double(Int.random(in: 1 ... 3))
    var viktories: Int?
    
    enum State: Int, CaseIterable {
        case awful = -4
        case bad = -2
        case normal = 1
        case good = 2
        case perfect = 3
    }
    
    var vSpeedDescription: String {
        if hSp < 56 { /// low
            return "slow horse"
        } else if hSp > 61 { /// high
            return "high horse"
        } else { /// medium
            return "slow horse"
        }
    }
    
    var vWeightDescription: String {
        if hWe < 450 { /// low
            return "not fat horse"
        } else if hWe > 550 { /// high
            return "medium horse"
        } else { /// medium
            return "slow horse"
        }
    }
    
    var vStateDescription: String {
        switch hSt! {
        case .awful:
            return "awful state"
        case .bad:
            return "bad state"
        case .normal:
            return "normal state"
        case .good:
            return "good state"
        case .perfect:
            return "perfect state"
        }
    }
    
    

}
