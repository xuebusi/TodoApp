//
//  ButtonDemoView.swift
//  TodoApp
//
//  Created by shiyanjun on 2023/7/31.
//

import SwiftUI

struct ButtonDemoView: View {
    @State var images: [String] = ["empty_01", "empty_02", "empty_03", "empty_04"]
    
    public let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var selection = 0
    
    var body: some View {
        GeometryReader { proxy in
            let screenHeight = proxy.size.height
            VStack {
                TabView(selection: $selection) {
                    ForEach(0..<images.count, id: \.self) { index in
                        Image(images[index])
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: screenHeight * 0.3)
                .background(Color(.systemBlue).opacity(0.6).edgesIgnoringSafeArea(.top))
                .tabViewStyle(PageTabViewStyle())
                //.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .onReceive(timer) { _ in
                    withAnimation {
                        selection = selection < 3 ? selection + 1 : 0
                    }
                }
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ButtonDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonDemoView()
    }
}
