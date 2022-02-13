//
//  Cardify.swift
//  Memorize
//
//  Created by Luke Lee on 2022/2/11.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var rotation: Double // in degrees
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            if rotation < 90 {
                shape.foregroundColor(.white)
                shape.strokeBorder(lineWidth: Constants.lineWidth)
                
            } else {
                shape.fill()
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0), perspective: 0.5)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
