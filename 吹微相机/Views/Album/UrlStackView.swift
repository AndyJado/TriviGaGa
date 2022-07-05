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
        Group {
            if vm.inCards.isEmpty {
                IcloudRefreshButton
            } else {
                ForEach(0..<vm.inCards.count, id: \.self) { i in
                    UrlCardView(UrlCard: UrlCard(record: vm.inCards[i].record) ?? UrlCard.exampleUrlCard) {
                        withAnimation {
                            vm.deleteItem(indexSet: [i])
                        }
                    }
                    .stacked(at: i, in: vm.inCards.count)
                }
            }
        }
    }
}

extension UrlStackView {
    var IcloudRefreshButton: some View {
        Button(action: {
            Task { try await vm.asyncFetch() }
        }) {
            Circle()
                .foregroundColor(Color.black.opacity(0.1))
                .frame(width: 50, height: 50, alignment: .center)
                .overlay {
                    if vm.isFetching {
                        ProgressView()
                    } else {
                        Image(systemName: "icloud.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(Theme.orange.mainColor)
                    }
                }
            
        }
        
    }
    
    
    
}


struct UrlStackView_Previews: PreviewProvider {
    static var previews: some View {
        UrlStackView()
    }
}
