// Deck.swift

import Foundation

class Deck: NSObject {
    static let allSpades = Value.allCases.map { value in
        Card(newColor: .spade, newValue: value)}
    static let allDiamonds = Value.allCases.map { value in
        Card(newColor: .diamond, newValue: value)
    }
    static let allHearts = Value.allCases.map { value in
        Card(newColor: .heart, newValue: value)
    }
    static let allClubs = Value.allCases.map { value in
        Card(newColor: .club, newValue: value)
    }
    
    static let allCards = allSpades + allDiamonds + allHearts + allClubs
}
