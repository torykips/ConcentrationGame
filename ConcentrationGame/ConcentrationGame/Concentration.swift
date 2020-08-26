//
//  Concentration.swift
//  ConcentrationGame
//
//  Created by Max on 7/25/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

class Concentration{
    private(set) var cards = [Card]()
    
    private var twoSecondAttemptTime: Date
    
    private(set) var flipCount = 0
    private(set) var score = 0
    private(set) var scoreBonus = false
    private var witnessedCards = [Card]()
    
    private var faceUpCardIndex: Int?{
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairs: Int) {
        assert(numberOfPairs > 0,
               "Concentartion.init(numberOfPairs: \(numberOfPairs)): You need at least 1 pair of cards")
        
        for _ in 1...numberOfPairs{
            let card = Card()
            cards += [card, card]
        }
        
        var lastCardIndex = cards.count - 1
        
        while lastCardIndex >= 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.swapAt(lastCardIndex, randomIndex)
            lastCardIndex -= 1
        }
        
        twoSecondAttemptTime = Date.init()
        }
    
    func reset() {
        flipCount = 0
        score = 0
        scoreBonus = false
        for index in 0..<cards.count{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        witnessedCards.removeAll()
        cards.removeAll()
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.choseCard(at: \(index)): Chosen index is not in cards")
        
        if !cards[index].isMatched{
            flipCount += 1
            
            if let matchedIndex = faceUpCardIndex, matchedIndex != index{
                
                if cards[index] == cards[matchedIndex]{
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    
                    if twoSecondAttemptTime > Date.init() {
                        score += 1
                        scoreBonus = true
                    }else{
                        scoreBonus = false
                    }
                    
                }else{
                    if witnessedCards.contains(where: {$0 == cards[index]}) {
                        score -= 1
                    }
                    if witnessedCards.contains(where: {(card: Card)->Bool in
                        card == cards[matchedIndex]
                    }) {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
                witnessedCards += [cards[index], cards[matchedIndex]]
            }else{
                faceUpCardIndex = index
                
                scoreBonus = false
                twoSecondAttemptTime = Date.init().addingTimeInterval(2)
            }
            
        }
    }
    
}
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
