//
//  EmojiMemoryGameView.swift
//  Shared
//
//  Created by Luke Lee on 2022/1/16.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && !card.isFaceUp {
                Color.clear.opacity(0)
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
        }
        .foregroundColor(.orange)
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        if game.cards.first != nil {
            game.choose(game.cards.first!)
        }
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}

struct CardView: View {
    var card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 60)
                )
                    .padding(5)
                    .opacity(0.5)
                Text(card.content)
                    .font(font(in: geometry.size))
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(.easeInOut(duration: 1), value: card.isMatched)
                    // NEW API Actually fix that wanky animation with "Font Cannot be Animated, use scaleEffect to change font size"
                
//                    .font(.system(size: Constants.fontSize))
//                    .scaleEffect(scale(thatFit: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
//    private func scale(thatFit size: CGSize) -> CGFloat {
//        min(size.width, size.height) / Constants.fontSize * Constants.fontScale
//    }
    
    private func font(in size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * Constants.fontScale)
    }
    
    private struct Constants {
        static let fontScale: CGFloat = 0.7
//        static let fontSize: CGFloat = 32
    }
}
