// main.swift

print("----------")

let firstCard = Card(newColor: .hearts, newValue: .queen)
print("The first card:      \(firstCard)")

let secondCard = Card(newColor: .hearts, newValue: .queen)
print("The second card:     \(secondCard)")

let thirdCard = Card(newColor: .spade, newValue: .eight)
print("The third card:      \(thirdCard)")

print("----------")

print("Compare cards:")
print("The first card == the second card    |   \(firstCard == secondCard)")
print("The first card == the third card     |   \(firstCard == thirdCard)")

print("The first card isEqual the second card    |   \(firstCard.isEqual(to: secondCard))")
print("The first card isEqual the third card     |   \(firstCard.isEqual(to: thirdCard))")


