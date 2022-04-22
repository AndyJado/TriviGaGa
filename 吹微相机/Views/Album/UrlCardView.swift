//
//  UrlCardView.swift
//  DDay
//
//  Created by Andy Jado on 2022/4/19.
//

import SwiftUI

struct UrlCardView: View {
    @State private var offset = CGSize.zero
    
    let UrlCard: UrlCard
    let theme: Theme = .buttercup
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(theme.mainColor)
                .frame(width: 320, height: 410)
                .shadow(radius: 5)
                .overlay {
                    AsyncImage(url: UrlCard.imageURL) { phase in
                        switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let returnedImage):
                                returnedImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 320, height: 300)
                                    .clipped()
                            case .failure:
                                Image(systemName: "questionmark")
                                    .font(.headline)
                            default:
                                Image(systemName: "questionmark")
                                    .font(.headline)
                        }
                    }
                }
        }
        .padding(.all, 30)
        .padding(.top, 10)
        .padding(.bottom, 240)
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

struct UrlCardView_Previews: PreviewProvider {
    static var previews: some View {
        UrlCardView(UrlCard: UrlCard.exampleUrlCard)
    }
}
