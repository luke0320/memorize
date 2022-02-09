//
//  MemoryGame.swift
//  Memorize
//
//  Created by Luke Lee on 2022/2/4.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    
    private(set) var cards: [Card]
    
    private var didChooseIndex: Int? {
        set { cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue }}
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        
        guard
            let willChooseIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[willChooseIndex].isFaceUp,
            !cards[willChooseIndex].isMatched
        else {
            return
        }
        
        if let didChooseIndex = didChooseIndex {
            if cards[didChooseIndex].content == cards[willChooseIndex].content {
                cards[didChooseIndex].isMatched = true
                cards[willChooseIndex].isMatched = true
            }
            cards[willChooseIndex].isFaceUp = true
        } else {
            didChooseIndex = willChooseIndex
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        count == 1 ? first : nil
    }
}
