//
//  BaseQuest.swift
//  Focus
//
//  Created by Igor Starobor on 18.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

protocol BaseQuestDelegate: class {
    func currentTaskChanged()
}

class BaseQuest {
    
    var tasks: [Task] = []
    
    var currnetTask: BehaviorRelay<Task>
    var currentTaskDisposable: Disposable?
    
    private weak var _delegate: BaseQuestDelegate?
    weak var delegate: BaseQuestDelegate? {
        get {
            return self._delegate
        }
        set {
            self._delegate = newValue
            currentTaskDisposable = currnetTask.subscribe({ (event) in
                newValue?.currentTaskChanged()
            })
        }
    }
    
    init(tasks: [Task]) {
        self.tasks = tasks
        currnetTask = BehaviorRelay(value: tasks.first)
    }
    
    
}
