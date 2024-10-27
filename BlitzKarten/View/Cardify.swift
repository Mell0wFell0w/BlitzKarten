//
//  Cardify.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/26/24.
//

import Foundation
import SwiftUI

struct Cardify: Animatable, ViewModifier {
    var isFaceUp: Bool {
        rotation < 90
    }

    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }

    var rotation: Double

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                if isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size))
                        .fill(Color.white)
                        .shadow(radius: 5)
                    content.opacity(isFaceUp ? 1 : 0)
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size))
                        .fill(Color.gray)
                        .shadow(radius: 5)
                    content.opacity(isFaceUp ? 0 : 1)
                }
            }
            .rotation3DEffect(Angle(degrees: rotation), axis: (0, 1, 0))
        }
    }

    // MARK: - Drawing constants

    private func cornerRadius(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.08
    }
}

// Extension to easily apply Cardify
extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
