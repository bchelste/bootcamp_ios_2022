// main.swift

print("----------")
print("\u{2660} \u{2666} \u{2665} \u{2663}")

var pack = Deck.allCards

print("pack before had been shuffled:")
for (i, card) in pack.enumerated() {
    print("\(i+1): \(card)")
}
print("|||||")

pack.myShuffle()

print("pack after had been shuffled:")
for (i, card) in pack.enumerated() {
    print("\(i+1): \(card)")
}







