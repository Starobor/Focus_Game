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
    let hName = HorseNames.names.randomElement()
    var hSp = Double(Int.random(in: 50 ... 65))
    var hAg = Double(Int.random(in: 4 ... 18))
    var hWe = Double(Int.random(in: 400 ... 600))
    var hSt = State.allCases.randomElement()
    var hEx = Double(Int.random(in: 2 ... 9))
    let rName = RiderNames.names.randomElement()
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
            return ParametersPlayerDescription.HSpeed.slow.randomElement()!
        } else if hSp > 61 { /// high
            return ParametersPlayerDescription.HSpeed.high.randomElement()!
        } else { /// medium
            return ParametersPlayerDescription.HSpeed.medium.randomElement()!
        }
    }
    
    var vWeightDescription: String {
        if hWe < 450 { /// low
            return ParametersPlayerDescription.HWeight.skinny.randomElement()!
        } else if hWe > 550 { /// high
            return ParametersPlayerDescription.HWeight.fat.randomElement()!
        } else { /// medium
            return ParametersPlayerDescription.HWeight.medium.randomElement()!
        }
    }
    
    var vStateDescription: String {
        switch hSt! {
        case .awful:
            return  ParametersPlayerDescription.HState.awful.randomElement()!
        case .bad:
            return  ParametersPlayerDescription.HState.bad.randomElement()!
        case .normal:
            return  ParametersPlayerDescription.HState.medium.randomElement()!
        case .good:
            return  ParametersPlayerDescription.HState.good.randomElement()!
        case .perfect:
            return  ParametersPlayerDescription.HState.perfect.randomElement()!
        }
    }
    
    var vAgeDescription: String {
        if hAg < 8 { /// low
            return ParametersPlayerDescription.HAge.young.randomElement()!
        } else if hAg > 15 { /// high
            return ParametersPlayerDescription.HAge.old.randomElement()!
        } else { /// medium
            return ParametersPlayerDescription.HAge.medium.randomElement()!
        }
    }
    
    var vExperienceDescription: String {
        if hEx < 4 { /// low
            return ParametersPlayerDescription.HExperience.bad.randomElement()!
        } else if hEx > 6 { /// high
            return ParametersPlayerDescription.HExperience.good.randomElement()!
        } else { /// medium
            return ParametersPlayerDescription.HExperience.medium.randomElement()!
        }
    }
    
    var rStateDescription: String {
        switch rSt! {
        case .awful:
            return ParametersPlayerDescription.RState.awful.randomElement()!
        case .bad:
            return ParametersPlayerDescription.RState.bad.randomElement()!
        case .normal:
            return ParametersPlayerDescription.RState.medium.randomElement()!
        case .good:
            return ParametersPlayerDescription.RState.good.randomElement()!
        case .perfect:
            return ParametersPlayerDescription.RState.perfect.randomElement()!
        }
    }
    
    var rExperienceDescription: String {
        if rEx < 3 { /// low
            return ParametersPlayerDescription.RExperience.bad.randomElement()!
        } else if rEx > 7 { /// high
            return ParametersPlayerDescription.RExperience.good.randomElement()!
        } else { /// medium
            return ParametersPlayerDescription.RExperience.medium.randomElement()!
        }
    }
    
    var rWeightDescription: String {
        if rWe < 45 { /// low
            return ParametersPlayerDescription.RWeight.skinny.randomElement()!
        } else if rWe > 55 { /// high
            return ParametersPlayerDescription.RWeight.fat.randomElement()!
        } else { /// medium
            return ParametersPlayerDescription.RWeight.medium.randomElement()!
        }
    }
    
    var rAgeDescription: String {
        if rAg < 20 { /// low
            return ParametersPlayerDescription.RAge.young.randomElement()!
        } else if rAg > 25 { /// high
            return ParametersPlayerDescription.RAge.old.randomElement()!
        } else { /// medium
            return ParametersPlayerDescription.RAge.medium.randomElement()!
        }
    }
    
    var tDistanceInteractionDescription: String {
        switch gDi {
        case 1:
            return ParametersPlayerDescription.TDistance.short.randomElement()!
        case 2:
            return ParametersPlayerDescription.TDistance.medium.randomElement()!
        case 3:
            return ParametersPlayerDescription.TDistance.long.randomElement()!
        default:
            return ""
        }
    }
    
    var tWeatherInteractionDescription: String {
        switch gWe {
        case 1:
            return ParametersPlayerDescription.TWeather.common.randomElement()!
        case 2:
            return ParametersPlayerDescription.TWeather.rain.randomElement()!
        case 3:
            return ParametersPlayerDescription.TWeather.snow.randomElement()!
        case 4:
            return ParametersPlayerDescription.TWeather.hot.randomElement()!
        default:
            return ""
        }
    }
    
    var tStateInteractionDescription: String {
        switch gTr {
        case 1:
            return ParametersPlayerDescription.TState.strong.randomElement()!
        case 2:
            return ParametersPlayerDescription.TState.sand.randomElement()!
        case 3:
            return ParametersPlayerDescription.TState.swamp.randomElement()!
        case 4:
            return ParametersPlayerDescription.TState.forest.randomElement()!
        default:
            return ""
        }
    }
    
    var tTimeInteractionDescription: String {
        switch gTi {
        case 1:
            return ParametersPlayerDescription.TTime.morning.randomElement()!
        case 2:
            return ParametersPlayerDescription.TTime.midday.randomElement()!
        case 3:
            return ParametersPlayerDescription.TTime.evening.randomElement()!
        default:
            return ""
        }
    }
    
}

class ParametersPlayerDescription {
    
    class HSpeed {
        static let slow     = ["Настільки повільний, що не може наздогнати навіть власний хвіст.",
                               "Спить на півдорозі.",
                               "Любить приходити останнім.",
                               "Неквапливий, обережний, ходить а не бігає.",
                               "Має дивіз тихіше їдеш далі будеш.",
                               "Ледачий навіть з сараю виходити.",
                               "Швидкість не про нього.",
                               "Не бачить сенсу кудись бігати, йому й так добре.",
                               "Любить поспати, тільки у снах швидко і бігає.",
                               "Помалу ходить, коліна на погоду шось крутять.",
                               "Швидкий як корова.",
                               "Про таких кажуть, що де сядеш там і злізеш.",
                               "Завжди перший, правда з кінця."]
        
        static let medium   = ["Показує стабільну швидкость.",
                               "Нічим не виділяється по швидкості.",
                               "Швидкість може бути кращою, але і цього достатньо.",
                               "Швидкість не вражає, але й не розчаровує.",
                               "Ні риба ні м'ясо, добре хоч скаче.",
                               "Годиця хіба сіно возити.",
                               "Стабільний, як тиск твоєї бабці.",
                               "Скаче й на тому спасибі.",
                               "Ніколи не перевищує швидкості, не ризикує.",
                               "Живе за принципом тихіше їдеш, далі будеш.",
                               "Має низьку самооцінку, от і не приходить першим.",
                               "В гонках вважає головним не перемогу, а участь.",
                               "Так собі бігун, але цілеспрямований, колись та доїде."]
        
        static let high     = ["Швидкий як вітер.",
                               "Прудко бігає, наче за ним хто женеця.",
                               "Раніше показував вражаючі результати швидкості.",
                               "Настільки швидкий, що не кожен вершник у змозі втриматися на ньому.",
                               "Дурна голова, швидкі ноги.",
                               "Швидкий, як птах, як літак, як суперкінь.",
                               "Він ніколи нікуди не запізнюється.",
                               "В нього завжди одне копито тут, друге копито там.",
                               "Кажуть цей кінь вміє літати.",
                               "Ніхто не знає рябий він чи ні, а як розгледіти на такій швидкості.",
                               "Від себе не втечеш, але цей кінь надто швидко бігає.",
                               "Колись злякався вовка, біжить ще досі.",
                               "В нього точно більше ніж одна кінська сила."]
    }
    
    class HAge {
        static let young    = ["Зовсім недано на сцені.",
                               "Молодий, можливо, навіть занадто.",
                               "Мабуть, його ще досі кормлять молоком.",
                               "Ще навіть копита не виросли.",
                               "Ніжки тремтять, ще ходити не навчився.",
                               "Вперше на гонках."]
        
        static let medium   = ["Зололта середина, вік ідеальний для спорту.",
                               "Схоже в нього криза середнього віку.",
                               "В самому розквіті сил.",
                               "Вже не молодий, та й не старий ще.",
                               "Зрілий, знає що до чого."]
        
        static let old      = ["Хто-небуть має дати йому піти на пенсію.",
                               "Для деяких учасників він згодиться дідом.",
                               "Його завжди можна знайти за слідами від піску, що з нього сиплеться.",
                               "Старий кінь, як то кажуть, але там видно буде.",
                               "Та старість не радість, буде добре якщо дід переживе цю гонку.",
                               "За спинами про нього говорять \"стара шкапа\"."]
    }
    
    class HWeight {
        static let skinny   = ["Виглядає наче його не годують.",
                               "Схожий на поні.",
                               "Треба бути обережним, щоб його не здуло вітром і не заносило на поворотах.",
                               "Якщо цей кінь не зламається коли на нього сядуть, буде брати участь в гонках.",
                               "В коня виглядають ребра, але може так ліпша аеродинаміка.",]
        
        static let medium   = ["Кінь як з картинки, а грива яка.",
                               "Кінь виглядає так, наче увесь час тренується, мабуть окрім тренувань ніякого особистого життя.",
                               "Вигляда непогано, видно за ним доглядають.",
                               "Його тримають у гарній формі.",
                               "А які мускули в нього, от шо значить здорове харчування."]
        static let fat      = ["Один, а їсть за двох, важить теж за двох.",
                               "Лишається вірити що такі товсті коні не падають посеред траси від серцевого нападу.",
                               "Товстенький, але якщо на фініші поставити мішок вівса, є шанс на перемогу.",
                               "В поганій формі, ніхто не знає він бігає, чи котиться, але в правилах забігу про це ні слова.",
                               "Не завадило б з такими параметрами сісти на дієту, але хто ми такі щоб йому вказувати."]
    }
    
    class HState {
        static let awful    = ["В минулому цей кінь себе добре показував, але зараз видно, що він не тверезо                    дивиться на скачки.",
                               "А де його четверта нога? Що ж, залишається побажати йому успіхів."]
        static let bad      = ["Правда наїзник ще той п'яниця, хто зна шо від нього очікувать.",
                               "Позавчора наїзник зїв три відра морозива і застудився.",
                               "В ніч перед перегонами наїзник вирішив повеселитись на вечірці.",
                               "Наїзник страждає на безсоння вже другий тиждень.",
                               "Щойно дружина наїзника зателефонувала йому й сказала що подає на розлучення."]
        static let medium   = ["І кінь, і наїзник давно готувались до перегонів, сьогодні бодрі на старті.",
                               "Наїзник вирішив добре виспатись, на кону перемога.",
                               "Зранку наїзник в чудовому настрої, ніщо йому не завадить.",
                               "Сьогодні наїзник вдягнув свою щасливу сорочку.",
                               "У наїзника гарний гороскоп, все говорить про удачу.",
                               "Вершник на коні, в прямому і переносному сенсі."]
        static let good     = ["Ходять слухи шо цей учасник сидить на допінгах, хоч бо не було скандалів.",
                               "Заради перемоги наїзник готовий на все, надто багато стоїть на вагах, використав стимулятори.",
                               "Наїзник дав сьорбнути коню енергетик, а якщо допоможе.",
                               "Наїзник годував чимось незрозумілим коней конкурентів, здається це не зовсім чесно.",
                               "Поки ніхто не бачить наїзник підлив у відро з водою своєму коню якусь дивну сироватку."]
        static let perfect   = ["Схоже, що цей кінь в ідеальному стані.",
                                "Цей рисак виглядає, найче йому надає сил сам Бог."]
    }
    
    class HExperience {
        static let bad      = ["Вперше на гонках, вирішив спробувати свої сили.",
                               "Новачкам кажуть щастить.",
                               "Здається раніше його тут ніхто не бачив, темна конячка.",
                               "Вчора на полі картоплю возив, а сьогодні вже на гонках.",
                               "Такого в нас ще не було, він хоч знає в яку сторону бігти."]
        static let medium   = ["В котрий раз ми бачимо його на трасі, ніяк не полишає надію на перемогу .",
                               "Скільки гонок пройшло, а йому ніяк не набридне бігати по колу, вже б щось нове спробував.",
                               "Кілька заїздів вже за спиною, всі надії на сьогодні.",
                               "Маємо надію що всі тренування не дарма і друге дихання його врятує.",
                               "Немало вже пробіг і нехай біжить далі,бо заберуть назад на ферму."]
        static let good     = ["Він знає трасу, як свої підкови.",
                               "Здається цей учасник зміг би пробігти дистанцію з зав'язаними очима.",
                               "Досвіду йому не займати.",
                               "Він нічим крім гонок в житті не займався.",
                               "Все в тренуваннях, гонках, скачках."]
        
    }
    
    class RAge {
        static let young    = ["А цей дід не розсиплеться на коні.",
                               "Дід може не дійти фінішу, просто забуде через склероз куди їхав.",
                               "Такий малий шо й коня не втримає."]
        static let medium   = ["Старуватий для гонок, але своє діло знає.",
                               "Замолодий хлопчина, але ми ж не ейджисти, їздити вміє."]
        static let old      = ["В ідеальному віці для гонки."]
    }
    
    class RWeight {
        static let skinny   = ["Худощавий наїзник, але може це зіграє йому на користь, те що треба для                          перемоги."]
        static let medium   = ["Виглядає непогано, але надто нервовий та невпевнений, тут не вгадаєш."]
        static let fat      = ["А форма далека від спортивної, хоч би кін не зламався."]
            
    }
    
    class RExperience {
        static let bad     = ["Він на коні хоч вміє їздити.",
                              "Несіть драбину щоб ця дитина влізла на коня.",
                              "Невідомо чи дали батьки йому дозвіл на участь в гонках.",
                              "Вчора коня вперше побачив.",
                              "А права в цього підлітка на керування конем є?."]
        static let medium   = ["Не вперше на коня сві, але ще тренуватись не завадило б."]
        static let good     = ["Півжиття провів на скачках.",
                               "Він на коні все життя.",
                               "Ніхто не провів стільки часу на коні, як він.",
                               "Цей чоловік виріс на коні.",
                               "Він з конем одне ціле."]
    }
    
    class RState {
        static let awful    = ["Бідний вершник, грошей вистачило тільки на віслюка, якого він пофарбував в                      коня"]
        static let bad      = ["Ледь нашкріб грошей, щоб коня підкувати."]
        static let medium   = ["Він живе за рахунок участі в гонках, не на широку ногу, але кінь ситий."]
        static let good     = ["Хазяєн ферми, зразу видно, найкращий кінь, найкращі підкови."]
        static let perfect  = ["Цьому вершнику не шкода ні копійки на гонки, у коня навіть зуби золоті."]
    }
    
    class TDistance {
        static let short    = ["Кінь як то кажуть для коротких дистанцій."]
        static let medium   = ["Власник цього коня дуже пишається своїми перемогами на середніх дистанціях."]
        static let long     = ["Кінь, що натренерований на довгі гонки."]
    }
    
    class TWeather {
        static let common    = ["Цей скакун звик бігати тільки по гарній сонячній погоді."]
        static let rain      = ["Кажуть, що коли дощить, то це йому тільки на користь."]
        static let snow      = ["Власник цього коня поставив йому зимову підкову. Чи допоможе це йому в                           сьогоднішніх гонках?"]
        static let hot       = ["Кажуть, що цього коня виховували в пустелях Сахари, тому йому не страшна                         ніяка спека"]
    }
    
    class TState {
        static let strong    = ["Асфальтовий кінь, ніразу не бігав по іншим дорогам."]
        static let sand      = ["Його підкови викувані навмисне для піщаних доріг, та чи допоможе це йому                         сьогодні"]
        static let swamp     = ["Болотяна трясовина йому нідочого, він постійно по такій бігає до хати."]
        static let forest    = ["В лісі він точно не заблукає."]
    }
    
    class TTime {
        static let morning   = ["Видно власник рання пташка, раз прийшов за 2 години до початку."]
        static let midday    = ["Звичайний вершник, який бігає тільки пообіду."]
        static let evening   = ["А чесно використовувати окуляри нічного бачення?"]
      
    }
}

