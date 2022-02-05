//
//  MemoryGame.swift
//  Memorize
//
//  Created by Luke Lee on 2022/2/4.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    
    private(set) var cards: [Card]
    
    private var didChooseIndex: Int?
    
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
            self.didChooseIndex = nil
            
        } else {
            for i in cards.indices {
                cards[i].isFaceUp = false
            }
            didChooseIndex = willChooseIndex
        }
        
        cards[willChooseIndex].isFaceUp = true
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
