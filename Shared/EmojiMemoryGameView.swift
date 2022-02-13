//
//  EmojiMemoryGameView.swift
//  Shared
//
//  Created by Luke Lee on 2022/1/16.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    @State private var dealt: Set<Int> = []
    
    @Namespace private var dealingNameSpace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameBody
                HStack {
                    restart
                    Spacer()
                    shuffle
                }
                .padding(.horizontal)
            }
            deckBody
        }
        .padding()
        
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: CardConstants.aspectRatio) { card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .padding(4)
                    .zIndex(zIndex(for: card))
                    .transition(.asymmetric(insertion: .identity, removal: .scale))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(CardConstants.color)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) {
                CardView(card: $0)
                    .matchedGeometryEffect(id: $0.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(for: $0))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            game.cards.forEach { card in
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var shuffle: some View {
        Button("SHUFFLE") {
            withAnimation {
                game.shuffle()
            }
        }
    }
    
    var restart: some View {
        Button("RESTART") {
            withAnimation {
                dealt = []
                game.restart()
            }
        }
    }
    
    func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        let delay = Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0) * CardConstants.totalDealDuration / Double(game.cards.count)
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    func zIndex(for card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2 / 3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
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
    
    @State private var animatedBonusRemaining: Double = 0
    var card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Group {
                    let startAngle = Angle(degrees: -90)
                    if card.isConsumingBonusTime {
                        Pie(
                            startAngle: startAngle,
                            endAngle: Angle(degrees: (-animatedBonusRemaining) * 360 - 90)
                        )
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(
                            startAngle: startAngle,
                            endAngle: Angle(degrees: (-card.bonusRemaining) * 360 - 90)
                        )
                    }
                }
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
