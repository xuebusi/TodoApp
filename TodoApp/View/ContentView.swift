//
//  ContentView.swift
//  Todo App
//
//  Created by shiyanjun on 7/13/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var iconSettings: IconNames
    
    @State private var showingAddTodoView: Bool = false
    @State private var showingSettingsView: Bool = false
    @StateObject var vm: ViewModel = ViewModel()
    @State private var animatingButton: Bool = false
    
    @EnvironmentObject var theme: ThemeSettings
    var themes: [Theme] = themeData
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(vm.todos, id: \.self) { todo in
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundColor(self.colorize(priority: todo.priority ?? "中"))
                            Text(todo.name ?? "未知")
                                .fontWeight(.semibold)
                                //.lineLimit(1)
                            
                            Spacer()
                            
                            Text(todo.priority ?? "未知")
                                .font(.footnote)
                                .foregroundColor(Color(.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule().stroke(Color(.systemGray2))
                                )
                        } //: HSTACK
                        .padding(.vertical, 10)
                    }
                    .onDelete(perform: deleteTodo)
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("待办事项", displayMode: .inline)
                .navigationBarItems(
                    trailing:
                        Button {
                            self.showingSettingsView.toggle()
                        } label: {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                        }
                        //.accentColor(themes[self.theme.themeSettings].themeColor)
                        .accentColor(self.theme.currentThemeColor)
                        .sheet(isPresented: $showingSettingsView, content: {
                            SettingsView()
                                .environmentObject(iconSettings)
                        })
                )
                
                if vm.todos.isEmpty {
                    EmptyListView()
                }
            } //: ZSTACK
            .sheet(isPresented: $showingAddTodoView, content: {
                AddTodoView()
            })
            .onAppear {
                // 启动时加载颜色主题设置
                let themeColor = themes[self.theme.themeKey].themeColor
                theme.currentThemeColor = themeColor
            }
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            //.fill(themes[self.theme.themeSettings].themeColor)
                            .fill(self.theme.currentThemeColor)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            //.fill(themes[self.theme.themeSettings].themeColor)
                            .fill(self.theme.currentThemeColor)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
                    .animation(
                        Animation.easeInOut(duration: 2).repeatForever(autoreverses: true),
                        value: animatingButton)
                    
                    Button {
                        self.showingAddTodoView.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    } //: BUTTON
                    //.accentColor(themes[self.theme.themeSettings].themeColor)
                    .accentColor(self.theme.currentThemeColor)
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                } //: ZSTACK
                    .padding()
                , alignment: .bottom
            )
        } //: NAVIGATION
        .environmentObject(vm)
        .environmentObject(theme)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            vm.todos.remove(at: index)
        }
    }
    
    private func colorize(priority: String) -> Color {
        switch priority {
        case "高":
            return .pink
        case "中":
            return .green
        case "低":
            return .blue
        default:
            return .gray
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ThemeSettings())
    }
}
