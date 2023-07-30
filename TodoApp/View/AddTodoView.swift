//
//  AddTodoView.swift
//  Todo App
//
//  Created by shiyanjun on 7/13/23.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm: ViewModel
    
    @State private var name: String = ""
    @State private var priority: String = "中"
    
    let priorities = ["高", "中", "低"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    @EnvironmentObject var theme: ThemeSettings
    var themes: [Theme] = themeData
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    TextField("待办", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24, weight: .bold, design: .default))
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        if self.name != "" {
                            vm.save(todo: Todo(name: self.name, priority: self.priority))
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "名称无效"
                            self.errorMessage = "Make sure to enter something for\nthe new todo item."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("保存")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            //.background(themes[self.theme.themeSettings].themeColor)
                            .background(self.theme.currentThemeColor)
                            .cornerRadius(9)
                            .foregroundColor(Color.white)
                    })
                } //: VSTACK
                .padding(.horizontal)
                .padding(.vertical, 30)
                
                Spacer()
            }
            .navigationBarTitle("新建待办", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            )
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("确定")))
            }
            
        } //: NAVIGATION
        //.accentColor(themes[self.theme.themeSettings].themeColor)
        .accentColor(self.theme.currentThemeColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
