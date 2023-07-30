//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by shiyanjun on 7/14/23.
//

import SwiftUI

@main
struct TodoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(IconNames())
                .environmentObject(ThemeSettings())
                .preferredColorScheme(.light)
        }
    }
}
