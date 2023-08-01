//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by shiyanjun on 7/14/23.
//

import SwiftUI

@main
struct TodoAppApp: App {
    @StateObject var taskManager = TodoTaskManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(IconNames())
                .environmentObject(ThemeSettings())
                .preferredColorScheme(.light)
                .environment(\.managedObjectContext, taskManager.container.viewContext)
        }
    }
}
