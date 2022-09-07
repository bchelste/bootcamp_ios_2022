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

extension Array {
    
    mutating func myShuffle() {
        if self.count > 1 {
            for currentPosition in indices{
                let newPosition: Int = Int(arc4random_uniform(UInt32(self.count)))
                self.swapAt(currentPosition, newPosition)
            }
        }
    }
    
}
