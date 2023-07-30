//
//  ThemeSettings.swift
//  TodoApp
//
//  Created by shiyanjun on 2023/7/30.
//

import SwiftUI

class ThemeSettings: ObservableObject {
    @Published var themeKey: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeKey, forKey: "Theme")
        }
    }
    
    @Published var currentThemeColor: Color = .blue
}
