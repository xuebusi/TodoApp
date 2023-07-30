//
//  ThemeSettings.swift
//  TodoApp
//
//  Created by shiyanjun on 2023/7/30.
//

import SwiftUI

class ThemeSettings: ObservableObject {
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
    
    @Published var currentThemeColor: Color = .blue
}
