//
//  CardView.swift
//  DDay
//
//  Created by Andy Jado on 2022/4/9.
//

import SwiftUI

struct CardView: View {
    @State private var offset = CGSize.zero
    
//    let card: Card
    let card: String
    let theme: Theme = .buttercup
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(theme.mainColor)
                .frame(width: 320, height: 410)
                .shadow(radius: 5)
                .overlay {
                    Text(card)
                    .foregroundColor(.brown)
                    .multilineTextAlignment(.center)
                }

            
        }
        .padding(.all, 30)
        .padding(.top, 30)
        .padding(.bottom, 220)
        // movement
        .offset(x: offset.width, y: 0)
        .rotationEffect(.degrees(Double(offset.width / 20 )))
        .opacity(2 - Double(abs(offset.width / 100 )))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 150 {
                        // removal
                        removal?()
                    } else {
                        withAnimation(.spring()) {
                            offset = .zero
                        }
                    }
                }
        )
    }
    
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: "haha")
    }
}
