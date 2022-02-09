//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Luke Lee on 2022/2/4.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = [
        "🚘", "🚕", "🚙", "🚌", "🚗", "🚎",
        "🏎", "🚓", "🚑", "🚒", "🚐", "🛻",
        "🚚", "🚛", "🚜", "🦼", "🛴", "🚲",
        "🛵", "🏍", "🛺", "🚃", "🚝", "🚄"
    ]
    
    @Published private var model = MemoryGame(numberOfPairsOfCards: 4) { emojis[$0] }
    
    var cards: [Card] { model.cards }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
