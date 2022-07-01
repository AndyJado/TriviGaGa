//
//  CamButtonView.swift
//  Swipeable Cards
//
//  Created by Andy Jado on 2022/4/1.
//

import SwiftUI


struct ToggleButton: View {
//  @Binding var selected: Bool
    let action: () -> Void
    
  var body: some View {
      Button(action: action) {
              Circle()
              .foregroundColor(Theme.wheat.mainColor)
                  .frame(width: 80, height: 80, alignment: .center)
                  .overlay(
                      Circle()
                          .stroke(Color.black.opacity(0.8), lineWidth: 2)
                          .frame(width: 65, height: 65, alignment: .center)
                  )
      }
  }


struct ToggleButton_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
        ToggleButton(action: {})
    }
  }
}

}
