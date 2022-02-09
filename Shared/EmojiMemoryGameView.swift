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
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
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
                let shape = RoundedRectangle(cornerRadius: geometry.size.width * Constants.cornerRadiusScale)
                if card.isFaceUp {
                    shape.foregroundColor(.white)
                    shape.strokeBorder(lineWidth: Constants.lineWidth)
                    Pie(
                        startAngle: Angle(degrees: -90),
                        endAngle: Angle(degrees: 60)
                    )
                        .padding(5)
                        .opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                } else {
                    shape
                        .opacity(card.isMatched ? 0 : 1)
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * Constants.fontScale)
    }
    
    private struct Constants {
        static let cornerRadiusScale: CGFloat = 0.2
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}
