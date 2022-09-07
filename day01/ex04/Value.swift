// Value.swift

enum Value: Int, CaseIterable {
    case ace = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    
    static let allValues = allCases
    
}

extension Value: Comparable {
    
    static func < (lhs: Value, rhs: Value) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
