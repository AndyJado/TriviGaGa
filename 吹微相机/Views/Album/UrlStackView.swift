//
//  UrlStackView.swift
//  DDay
//
//  Created by Andy Jado on 2022/4/19.
//

import SwiftUI

struct UrlStackView: View {
    
    @StateObject private var vm = CKStackViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        ZStack {
            
            IcloudPeople()
            // ??
            
            IcloudRefreshButton
            
            ForEach(0..<vm.inCards.count, id: \.self) { i in
                UrlCardView(UrlCard: UrlCard(record: vm.inCards[i].record) ?? UrlCard.exampleUrlCard) {
                    withAnimation {
                        vm.deleteItem(indexSet: [i])
                    }
                }
                .stacked(at: i, in: vm.inCards.count)
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active { vm.fetchItems() }
        }
    }
}

extension UrlStackView {
    var IcloudRefreshButton: some View {
        Button(action: {
                vm.fetchItems()
        }) {
            Circle()
                .foregroundColor(Color.black.opacity(0.1))
                .frame(width: 50, height: 50, alignment: .center)
                .opacity(vm.inCards.isEmpty ? 1.0 : 0.0)
                .overlay(
                    Image(systemName: "icloud.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                    //                        .scaledToFill()
                        .foregroundColor(Theme.orange.mainColor))
                .opacity(vm.inCards.isEmpty ? 1.0 : 0.0)
            
        }
        
    }
    
    
    
}


struct UrlStackView_Previews: PreviewProvider {
    static var previews: some View {
        UrlStackView()
    }
}
