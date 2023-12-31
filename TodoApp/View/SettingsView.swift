//
//  SettingsView.swift
//  TodoApp
//
//  Created by shiyanjun on 2023/7/29.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var iconSettings: IconNames
    
    let themes: [Theme] = themeData
    @EnvironmentObject var theme: ThemeSettings
    //@State private var isThemeChanged: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    Section {
                        Picker(selection: $iconSettings.currentIndex) {
                            
                            ForEach(0..<iconSettings.iconNames.count, id:\.self) { index in
                                HStack {
                                    /**
                                     Image(uiImage: UIImage(named: self.iconSettings.iconNames[index]) ?? UIImage())
                                     .renderingMode(.original)
                                     .resizable()
                                     .scaledToFit()
                                     .frame(width: 44, height: 44)
                                     .cornerRadius(8)
                                     */
                                    
                                    Spacer().frame(width: 8)
                                    
                                    Text(iconSettings.iconNames[index])
                                        .frame(alignment: .leading)
                                }
                                .padding(3)
                            }
                            
                        } label: {
                            Text("图标")
                        }
                        .onChange(of: iconSettings.currentIndex) { index in
                            // 1.如果要正常修改应用程序图标，需要在Build Settings更该配置：
                            // Include All App Icon Assets=Yes
                            // 2.如果要显示修改成功提示为中文信息，需要在info.list中添加如下配置：
                            // Localized resources can be mixed=YES
                            UIApplication.shared.setAlternateIconName(iconSettings.iconNames[index])
                        }
                    } header: {
                        Text("选择一个应用图标")
                    }
                    .padding(.vertical, 3)
                    
                    Section {
                        List {
                            ForEach(themes, id:\.id) { item in
                                Button {
                                    self.theme.themeKey = item.id
                                    //UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                    self.theme.currentThemeColor = item.themeColor
                                    //self.isThemeChanged.toggle()
                                    
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(item.themeColor)
                                        
                                        Text(item.themeName)
                                    }
                                } //: BUTTON
                                .accentColor(Color.primary)
                            }
                        }
                    } header: {
                        HStack {
                            Text("Choose the app theme")
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                //.foregroundColor(themes[self.theme.themeSettings].themeColor)
                                .foregroundColor(self.theme.currentThemeColor)
                        }
                    }
                    .padding(.vertical, 3)
                    /**
                     .alert(isPresented: $isThemeChanged) {
                         Alert(
                             title: Text("SUCCESS!"),
                             message: Text("App has been changed to the \(themes[self.theme.themeKey].themeName). Now close and restart it!"),
                             dismissButton: .default(Text("OK"))
                         )
                     }
                     */

                    
                    Section {
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://swiftuimasterclass.com")
                        FormRowLinkView(icon: "link", color: Color.blue, text: "Twitter", link: "https://twitter.com/robertpetras")
                        FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "Courses", link: "https://www.udemy.com/user/robert-petras")
                    } header: {
                        Text("Follow us on social media")
                    }
                    .padding(.vertical, 3)
                    
                    
                    Section {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "John / Jane")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Robert Petras")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    } header: {
                        Text("About the applicaiton")
                    }
                    .padding(.vertical, 3)
                    
                } //: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                Text("Copyright @ All rights reserved.\nBetter Apps ♡ Less Code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            //.background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
            )
        } //: NAVIGATION
        //.accentColor(themes[self.theme.themeSettings].themeColor)
        .accentColor(self.theme.currentThemeColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(IconNames())
            .environmentObject(ThemeSettings())
    }
}
