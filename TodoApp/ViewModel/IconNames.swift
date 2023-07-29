//
//  IconNames.swift
//  TodoApp
//
//  Created by shiyanjun on 2023/7/29.
//

import Foundation
import SwiftUI

class IconNames: ObservableObject {
    var iconNames: [String] = ["Blue", "Green", "Orange", "Pink", "Purple", "Red"]
    @Published var currentIndex: Int = 0
}
