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
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(vm.todos, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "未知")
                                .lineLimit(1)
                            
                            Spacer()
                            
                            Text(todo.priority ?? "未知")
                        }
                    }
                    .onDelete(perform: deleteTodo)
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("待办事项", displayMode: .inline)
                .navigationBarItems(
                    trailing:
                        Button {
                            // self.showingAddTodoView.toggle()
                            self.showingSettingsView.toggle()
                        } label: {
                            Image(systemName: "paintbrush")
                                .imageScale(.large)
                        }
                        .sheet(isPresented: $showingSettingsView, content: {
                            // AddTodoView()
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
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(Color.blue)
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
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                } //: ZSTACK
                //.padding(.bottom, 15)
                //.padding(.trailing, 15)
                    .padding()
                , alignment: .bottom
            )
        } //: NAVIGATION
        .environmentObject(vm)
    }
    
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            vm.todos.remove(at: index)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
