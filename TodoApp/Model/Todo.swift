//
//  Todo.swift
//  TodoApp
//
//  Created by shiyanjun on 7/14/23.
//

import Foundation

struct Todo: Identifiable, Hashable {
    var id: UUID = .init()
    var name: String? = ""
    var priority: String? = "中"
}
