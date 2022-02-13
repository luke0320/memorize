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
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 5) { emojis[$0] }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: [Card] { model.cards }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
