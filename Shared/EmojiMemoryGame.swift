//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Luke Lee on 2022/2/4.
//

import Foundation

class EmojiMemoryGame {
    
    static let emojis = [
        "🚘", "🚕", "🚙", "🚌", "🚗", "🚎",
        "🏎", "🚓", "🚑", "🚒", "🚐", "🛻",
        "🚚", "🚛", "🚜", "🦼", "🛴", "🚲",
        "🛵", "🏍", "🛺", "🚃", "🚝", "🚄"
    ]
    
    typealias Card = MemoryGame<String>.Card
    
    private var model: MemoryGame<String> = MemoryGame(numberOfPairsOfCards: 4) { emojis[$0] }
    
    
    var cards: [Card] { model.cards }
    
}
