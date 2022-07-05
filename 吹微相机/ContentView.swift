//
//  ContentView.swift
//  DDay
//
//  Created by Andy Jado on 2022/4/9.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("UserName") var userName: String = "please try again"
    
    let theme: Theme = .ansiGreen
    
    var body: some View {
        ZStack{
            
            IcloudPeople()
            
            AsyncCamView()
            
            UrlStackView()
            
        }
        .background(theme.mainColor.opacity(0.89))
        .ignoresSafeArea()
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
