//
//  IcloudPeople.swift
//  DDay
//
//  Created by Andy Jado on 2022/4/19.
//

import SwiftUI

struct IcloudPeople: View {
    
    @State private var isSheetOn:Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isSheetOn.toggle()
                }) {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .foregroundColor(Color.black.opacity(0.5))
                        .frame(width: 50, height: 35, alignment: .center)
                        .overlay(
                            Image(systemName: "person.icloud")
                                .resizable()
                                .frame(width: 40, height: 30)
                                .foregroundColor(Color.black))
                    
                }
            }
            .opacity(0.1)
            .padding(.top,140)
            Spacer()
        }
        .sheet(isPresented: $isSheetOn) {
            NavigationView {
                RelationDetailView()
            }
        }
        
        
    }
    
    struct IcloudPeople_Previews: PreviewProvider {
        static var previews: some View {
            IcloudPeople()
        }
    }
}
