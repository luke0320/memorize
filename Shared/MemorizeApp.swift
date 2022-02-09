//
//  MemorizeApp.swift
//  Shared
//
//  Created by Luke Lee on 2022/1/16.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
