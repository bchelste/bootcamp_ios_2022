// main.swift

print("----------")
print("\u{2660} \u{2666} \u{2665} \u{2663}")
print("----------")

let sortedDeck = Deck(sorted: true)
let shuffleDeck = Deck(sorted: false)

print("sortedDeck:")
print(sortedDeck)
print("\n")
print("shuffleDeck:")
print(shuffleDeck)
print("\n")

print("draw")
for _ in 0..<5 {
    guard let drawCard = sortedDeck.draw() else { continue }
    print(drawCard)
}
print("\n")

print("sortedDeck 5 cards were drown")
print(sortedDeck)
print("outs: \(sortedDeck.outs)")
print("discards: \(sortedDeck.discards)")
print("---")

for card in sortedDeck.outs {
    sortedDeck.fold(c: card)
}

print("sortedDeck 5 cards were placed in discards")
print("outs: \(sortedDeck.outs)")
print("discards: \(sortedDeck.discards)")
print("\n")

print("draw")
for _ in 0..<3 {
    guard let drawCard = shuffleDeck.draw() else { continue }
    print(drawCard)
}
print("\n")

print("shuffleDeck 3 cards were drown")
print(shuffleDeck)
print("outs: \(shuffleDeck.outs)")
print("discards: \(shuffleDeck.discards)")
print("---")
for card in shuffleDeck.outs {
    shuffleDeck.fold(c: card)
}

print("shuffleDeck 3 cards were placed in discards")
print("outs: \(shuffleDeck.outs)")
print("discards: \(shuffleDeck.discards)")
print("\n")

print("!!!___!!!")

print("draw")
for _ in 0..<55 {
    guard let drawCard = sortedDeck.draw() else { continue }
    print(drawCard)
}
print("\n")

print("sortedDeck 55 cards were drown")
print(sortedDeck)
print("outs: \(sortedDeck.outs)")
print("discards: \(sortedDeck.discards)")
print("---")

for card in sortedDeck.outs {
    sortedDeck.fold(c: card)
}

print("sortedDeck rest cards were placed in discards")
print("outs: \(sortedDeck.outs)")
print("discards: \(sortedDeck.discards)")
print("\n")

