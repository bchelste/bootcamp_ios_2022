// main.swift

print("----------")

print("All Cards: \u{2660} \u{2666} \u{2665} \u{2663}")
for (i, item) in Deck.allCards.enumerated() {
    print("\(i+1): \(item)")
}
print("----------")

print("All Spades: \u{2660}")
print(Deck.allSpades)
print("----------")

print("All Diamonds: \u{2666}")
print(Deck.allDiamonds)
print("----------")

print("All Hearts: \u{2665}")
print(Deck.allHearts)
print("----------")

print("All Clubs: \u{2663}")
print(Deck.allClubs)
print("----------")




