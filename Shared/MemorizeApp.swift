//
//  MemorizeApp.swift
//  Shared
//
//  Created by Luke Lee on 2022/1/16.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
