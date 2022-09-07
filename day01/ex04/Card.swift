// Card.swift

import Foundation

class Card: NSObject {
    
    let color: Color
    let value: Value
    
    init(newColor: Color, newValue: Value)
    {
        color = newColor;
        value = newValue;
    }
    
    override var description: String {
        "\(value.rawValue) - \(color.rawValue)"
    }
    
    override func isEqual(to object: Any?) -> Bool {
        guard let card = object as? Card else { return false }
        return color == card.color && value == card.value
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color && lhs.value == rhs.value
    }

}

extension Card: Comparable {
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        if lhs.color != rhs.color {
            return lhs.color < rhs.color
        } else {
            return lhs.value < rhs.value
        }
    }
    
}
