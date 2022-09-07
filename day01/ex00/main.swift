// main.swift

print("-----------")
for suit in Color.allCases {
    for rank in Value.allCases {
        print("\(suit)   \(rank)")
    }
    print("-----------")
}
