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
    
    var cards = allCards
    var discards = Array<Card>()
    var outs = Array<Card>()
    
    init(sorted: Bool) {
        sorted ? cards.sort() : cards.myShuffle()
    }
    
    override var description: String {
        var result = ""
        for (i, card) in cards.enumerated() {
            result += "\(i + 1): \(card)\n"
        }
        return result
    }
    
    func draw() -> Card? {
        if cards.count > 0 {
            let victim = cards.removeFirst()
            outs.append(victim)
            return victim
        }
        return nil
    }
    
    func fold(c: Card) {
        if outs.contains(c) {
            discards.append(c)
        }
    }
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
