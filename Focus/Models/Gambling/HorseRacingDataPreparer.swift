//
//  HorseRacingDataPreparer.swift
//  Focus
//
//  Created by Igor Starobor on 16.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

class HorseRacingDataPreparer {
   
    let data: HorseRacingData
    
    enum DescriptionSentence: CaseIterable{
        case hWeight
        case hState
        case hSpeed
    }
    
    init(data: HorseRacingData) {
        self.data = data
    }
    
    func generatorPlayersData() -> [BaseGamblingPlayer] {
        var playersData: [BaseGamblingPlayer] = []
        for player in data.horses {
            let playerData = BaseGamblingPlayer(description: prepareDescription(player: player),
                                                 riderParametrs: prepareToDicRParams(player: player),
                                                 vehicleParametrs: prepareToDicHParams(player: player))
            playersData.append(playerData)
            
        }
        return playersData
    }
    
    func prepareDescription(player: HorseRacingPlayer) -> String {
        let sentenceTemplate = DescriptionSentence.allCases.shuffled()
        var description = ""
        for sentence in sentenceTemplate {
            description += textBy(sentence: sentence, with: player)
            description += " "
        }
        return description
    }
    
    
    func prepareToDicHParams(player: HorseRacingPlayer) -> [PlayerParametr] {
        return [PlayerParametr(name: "Age", value: "\(Int(player.hAg))"),
                PlayerParametr(name: "Weight", value: "\(Int(player.hWe))"),
                PlayerParametr(name: "Speed", value: "\(Int(player.hSp))")]
    }
    
    func prepareToDicRParams(player: HorseRacingPlayer) -> [PlayerParametr] {
        return [PlayerParametr(name: "Age", value: "\(Int(player.rAg))"),
                PlayerParametr(name: "Weight", value: "\(Int(player.rWe))"),
                PlayerParametr(name: "Experience", value: "\(Int(player.rEx))")]
    }
    
    func textBy(sentence: DescriptionSentence, with player: HorseRacingPlayer) -> String {
        switch sentence {
        case .hWeight:
            return player.vWeightDescription
        case .hState:
            return player.vStateDescription
        case .hSpeed:
            return player.vSpeedDescription
        }
    }
    
}

extension HorseRacingDataPreparer: BaseGamblingDataSource {
    var players: [BaseGamblingPlayer] {
        return generatorPlayersData()
    }
    
    var map: BaseGamblingMap {
        return BaseGamblingMap()
    }
}
