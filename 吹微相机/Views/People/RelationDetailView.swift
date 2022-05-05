//
//  RelationDetailView.swift
//  DDay
//
//  Created by Andy Jado on 2022/4/19.
//

import SwiftUI

struct RelationDetailView: View {
    
    @AppStorage("LovedOneName") var lovedOneName :String = ""
    @AppStorage("MiddleCode") var middleCode :String = ""
    @AppStorage("UserName") var userName: String = "reopen the sheet to refresh"
    
    @State private var tempCode : String = ""
    @State private var templovedOneName : String = ""
    @StateObject private var vm = CloudKitUserBootcampViewModel()

    
    var body: some View {
        Form {
            Section(header: Text("You")) {
                Text(userName)
            }
            
            Section(header: Text("code")) {
                TextField(middleCode, text: $tempCode)
            }
            
            Section(header: Text("lovedOne")) {
                TextField(lovedOneName, text: $templovedOneName)
            }

            
        }
        .onAppear {
            tempCode = middleCode
            templovedOneName = lovedOneName
        }
        .onDisappear {
            lovedOneName = templovedOneName
            middleCode = tempCode
        }
        .onChange(of: vm.userName) { newValue in
            userName = newValue
        }

    }
}

struct RelationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RelationDetailView()
    }
}
