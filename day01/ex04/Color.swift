//  Color.swift

enum Color: String, CaseIterable {
    case diamond
    case heart
    case club
    case spade
    
    static let allColors = allCases
    
}

extension Color: Comparable {
    
    static func < (lhs: Color, rhs: Color) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
