//
//  HorseRacingData.swift
//  Focus
//
//  Created by Igor Starobor on 16.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import Foundation

class HorseRacingData {
    
    let horseRacingGambling: HorseRacing
    
    var horses: [HorseRacingPlayer] {
        return horseRacingGambling.players
    }
    
    var map: HorseRacingMap {
        return horseRacingGambling.map
    }
    
    init() {
        var horses: [HorseRacingPlayer] {
            var horses: [HorseRacingPlayer] = []
            for _ in 0 ..< 5 {
                horses.append(HorseRacingPlayer())
            }
            return horses
        }
        let map = HorseRacingMap()
        
        horseRacingGambling = HorseRacing(players: horses, map: map)
    }
    
}
