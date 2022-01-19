//
//  ContentView.swift
//  Shared
//
//  Created by Luke Lee on 2022/1/16.
//

import SwiftUI

struct ContentView: View {
    
    let emojis = [
        "🚘", "🚕", "🚙", "🚌", "🚗", "🚎",
        "🏎", "🚓", "🚑", "🚒", "🚐", "🛻",
        "🚚", "🚛", "🚜", "🦼", "🛴", "🚲",
        "🛵", "🏍", "🛺", "🚃", "🚝", "🚄"
    ]
    
    @State var emojiCount = 5
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.orange)
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .padding(.horizontal)
            .font(.largeTitle)
        }
        .padding()
        
    }
    
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    
    var add: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}

struct CardView: View {
    
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
            } else {
                shape
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
        .font(.largeTitle)
    }
}
