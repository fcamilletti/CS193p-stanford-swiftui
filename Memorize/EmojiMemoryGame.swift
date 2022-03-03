//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Franco Camilletti on 06/10/2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    func newGame() {
        theme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        theme.emojis.shuffle()
    }
    
    init() {
        theme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
        theme.emojis.shuffle()
    }
    
    private static var themes: Array<Theme> = [
        Theme(name: "Vehicles", emojis: ["🛳","🏍","🛵","🚀","🚅","🚜","✈️","🚗","🛴"], numberOfPairsOfCards: 8, cardColor: "blue"),
        Theme(name: "Fruits", emojis: ["🍑","🍋","🍒","🥝","🥥","🍓","🥭","🍎","🍌"], numberOfPairsOfCards: 4, cardColor: "red"),
        Theme(name: "Animals", emojis: ["🐓","🐭","🐹","🐻","🐧","🐷","🐶"], numberOfPairsOfCards: 6, cardColor: "pink"),
        Theme(name: "Plants", emojis: ["🌷","🌺","🌴","🌱","🌲","🍄"], numberOfPairsOfCards: 7, cardColor: "green"),
        Theme(name: "Food", emojis: ["🍕","🍗","🍖","🍔","🥐","🍟"], numberOfPairsOfCards: 5, cardColor: "yellow"),
        Theme(name: "Objects", emojis: ["📸","☎️","📱","⏳","⏰","🧨","🔮"], numberOfPairsOfCards: 6, cardColor: "orange")
    ]
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    @Published private(set) var model: MemoryGame<String>
    
    private var theme: Theme
    
    var themeName: String {
        theme.name
    }
    
    var score: Int {
        model.score
    }
    
    var themeColor: Color {
        switch theme.cardColor {
        case "blue":
            return .blue
        case "red":
            return .red
        case "pink":
            return .pink
        case "green":
            return .green
        case "yellow":
            return .yellow
        case "orange":
            return .orange
        default:
            return .black
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: - User Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
