//
//  QuestManager.swift
//  Focus
//
//  Created by Igor Starobor on 18.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import Foundation
import SpriteKit

final class QuestManager {
    
    static let shared = QuestManager()
    
    func runQuest<T: BaseQuest>(_ scene: BaseMapScene, quest: T) {
        quest.delegate = self
        scene.showDialogWith(text: <#T##String#>, hero: <#T##Hero#>)
    }
    
}

extension QuestManager: BaseQuestDelegate {
    func currentTaskChanged() {
        
    }
}
