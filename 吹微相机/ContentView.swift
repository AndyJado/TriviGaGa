//
//  ContentView.swift
//  DDay
//
//  Created by Andy Jado on 2022/4/9.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("UserName") var userName: String = "please try again"
    
    var theme: Theme = .ansiGreen
    
    var body: some View {
        ZStack{
            theme.mainColor
                .ignoresSafeArea()
                .opacity(0.89)
            
            CameraView()
            
            UrlStackView()
            
            if userName == "please try again" {
                guideCardStack()
            }
            
            
        }
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
