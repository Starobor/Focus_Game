//
//  TrainingCowQuest.swift
//  Focus
//
//  Created by Igor Starobor on 18.10.2020.
//  Copyright © 2020 Igor Starobor. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

class TrainingCowQuest: BaseQuest {
    
    func runDialogsTasks() {
        if currnetTask.value != nil {
            scene?.moveComponent?.enabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [weak self] in
                self?.scene?.showDialogWith(text: self?.currnetTask.value?.text ?? "", hero: .cow)
                self?.goNextTask()
            }
        } else {
            scene?.moveComponent?.enabled = true
            scene?.removeDialog()
        }
    }
    
    func goNextTask() {
        let newTaskIndex =  tasks.index(after: tasks.firstIndex(where: {$0.action == currnetTask.value?.action}) ?? tasks.endIndex)
        if newTaskIndex < tasks.count - 1 {
            currnetTask.accept(tasks[newTaskIndex])
            scene?.showDialogWith(text: currnetTask.value?.text ?? "", hero: .cow)
        } else { /// complete last task
            currnetTask.accept(nil)
        }
        if let task = currnetTask.value {
            if task.action == .delay {
                runDialogsTasks()
            }
        }
    }
    
}
