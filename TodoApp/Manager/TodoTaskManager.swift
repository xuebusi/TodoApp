//
//  TodoTaskManager.swift
//  TodoApp
//
//  Created by shiyanjun on 2023/8/1.
//

import Foundation
import CoreData

class TodoTaskManager: ObservableObject {
    let container = NSPersistentContainer(name: "TodoModel")
    
    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
