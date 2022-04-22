//
//  ViewModifiers.swift
//  吹微相机
//
//  Created by Andy Jado on 2022/4/19.
//
import Foundation
import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let max = Double(total), now = Double(position)
        let indexDiff = max - now
        let ratio = (indexDiff - 1) / max
        let scaleset = 1.0 - ratio * 0.6
        let opacityset = 1 - ratio * 1.3
        return self.offset(x: 0, y: ratio * 250)
                    .opacity(opacityset)
                    .scaleEffect(scaleset)
                    
    }
}
