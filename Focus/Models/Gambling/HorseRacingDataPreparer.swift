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
        case hAge
        case hExperience
        case rState
        case rExperience
        case rWeight
        case rAge
        case tDi
        case tWe
        case tSt
        case tTi
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
    
    func generatorPlayersMap() -> BaseGamblingMap {
       let map = BaseGamblingMap()
        
        var distanceDescription: String {
            switch data.map.tDi {
            case 1:
                return "1.5 км"
            case 2:
                return "3 км"
            case 3:
                return "5 км"
            default:
                return "Невідомо"
            }
        }
        
        var weatherDescription: String {
            switch data.map.tWe {
            case 1:
                return "Сонячно"
            case 2:
                return "Дощ"
            case 3:
                return "Сніг"
            case 4:
                return "Спека"
            default:
                return "Невідомо"
            }
        }
        
        var stateDescription: String {
            switch data.map.tTr {
            case 1:
                return "Асфальт"
            case 2:
                return "Пляж"
            case 3:
                return "Болото"
            case 4:
                return "Ліс"
            default:
                return "Невідомо"
            }
        }
        
        var timeDescription: String {
            switch data.map.tTi {
            case 1:
                return "Ранок"
            case 2:
                return "Обід"
            case 3:
                return "Вечір"
            default:
                return "Невідомо"
            }
        }
        
        let distance = PlayerParametr(name: "distance", value: distanceDescription)
        let weather = PlayerParametr(name: "weather", value: weatherDescription)
        let state = PlayerParametr(name: "state", value: stateDescription)
        let time = PlayerParametr(name: "time", value: timeDescription)
        var description: String {
            var str = ""
            switch data.map.tDi {
            case 1:
                str += ["Коротка дистанція, вибрана головою сіль ради в місті Конотоп. Чудове місце з гарними видами на...",
                        "Невеликий трек в селі, що давно втратило назву, дешево та сердито. Ходять чутки, що тут бігали ще мамонти."].randomElement()!
            case 2:
                str += ["Не найдовша дистанція, але є коні, що й такої не переживуть."].randomElement()!
            case 3:
                str += ["Цей трек є одним з найдовших, його проходять лише обрані. Навіть Форест Гамп позаздрив би переможцю."].randomElement()!
            default:
                break
            }
            str += " "
            switch data.map.tWe {
            case 1:
             str += ["Гарна сонячна погода, що сприяє відносному гарному настрою. Такого тут вже давно не було, наче Зевс пішов у відпустку."].randomElement()!
            case 2:
                str += ["Дощить, як в Лондоні, добре, що деякі учасники взяли парасольки, але сподіваюсь це їм не завадить на скачках."].randomElement()!
            case 3:
                str += ["Страшно подумати, про тих учасників, що зараз на літній підкові, адже за вікном сніг, тому треба бути досить обережним на поворотах"].randomElement()!
            case 4:
                str += ["Фух... Такої спеки не було з 41-го, не кожен учасник зможе вижити за таких температур."].randomElement()!
            default:
                break
            }
            str += " "
            
            switch data.map.tTr {
            case 1:
                str += ["Гонка буде проходити на старому закинутому аеропорті. Тепер злітна смуга має інше      призначення, якщо звісно в нас немає таких шивидких коней."].randomElement()!
            case 2:
                str += ["Цікава буде гонка, не кожен жеребець зможе подолати піски Сахари."].randomElement()!
            case 3:
                str += ["Болото... хто взагалі допетрав проводити тут гонку? Байдуже, аби тільки учасники       були готові."].randomElement()!
            case 4:
                str += ["Видно, ялинки цього року дорогі, раз деякі учасники пішли вирубати собі пару               штук."].randomElement()!
            default:
               break
            }
            
            str += " "
                
            switch data.map.tTi {
            case 1:
                str += ["На годиннику шоста ранку, також це видно по обличчям деяких учасників, які ще досі сплять на коні."].randomElement()!
            case 2:
                str += ["Такий чудовий обідній час повинен допомогти учасникам в скачках. Але чи всім? Чув у одного коня боязнь сонця."].randomElement()!
            case 3:
                str += ["А на небі вже видно зорі, тому можемо розпочинати нашу гонку."].randomElement()!
            default:
                break
            }
            return str
        }
        map.description = description
        map.parametrs.append(distance)
        map.parametrs.append(weather)
        map.parametrs.append(state)
        map.parametrs.append(time)
        return map
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
        return [PlayerParametr(name: "Name", value: player.hName ?? ""),
                PlayerParametr(name: "Age", value: "\(Int(player.hAg))"),
                PlayerParametr(name: "Weight", value: "\(Int(player.hWe))"),
                PlayerParametr(name: "Speed", value: "\(Int(player.hSp))")]
    }
    
    func prepareToDicRParams(player: HorseRacingPlayer) -> [PlayerParametr] {
        return [PlayerParametr(name: "Name", value: player.rName ?? ""),
                PlayerParametr(name: "Age", value: "\(Int(player.rAg))"),
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
        case .hAge:
            return player.vAgeDescription
        case .hExperience:
            return player.vExperienceDescription
        case .rState:
            return player.rStateDescription
        case .rExperience:
            return player.rExperienceDescription
        case .rWeight:
            return player.rWeightDescription
        case .rAge:
            return player.rAgeDescription
        case .tDi:
            return player.tDistanceInteractionDescription
        case .tWe:
            return player.tWeatherInteractionDescription
        case .tSt:
            return player.tStateInteractionDescription
        case .tTi:
            return player.tTimeInteractionDescription
        }
    }
    
}

extension HorseRacingDataPreparer: BaseGamblingDataSource {
    var players: [BaseGamblingPlayer] {
        return generatorPlayersData()
    }
    
    var map: BaseGamblingMap {
        return generatorPlayersMap()
    }
}
