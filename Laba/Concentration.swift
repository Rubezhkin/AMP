//
//  concentration.swift
//  Laba
//
//  Created by   Павел Недобежкин on 23.10.2023.
//

import Foundation

struct Concentration{
    private (set) var cards = [Card]()
    private var numberOfCards: Int
    private var numberOfHints = 1
    var score = 0
    private var indexOfOneFaceUpCard: Int?
    
    mutating func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    score -= 1
                }
                cards[index].isFaceUp=true
                indexOfOneFaceUpCard = nil
            } else {
                for i in cards.indices{
                    cards[i].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, numberOfButtons: Int){
        numberOfCards = numberOfPairsOfCards*2
        for _ in 1...(numberOfButtons+1)/2{
            let card = Card()
            cards += [card,card]
        }
        for i in numberOfCards..<numberOfButtons{
            cards[i].isMatched = true
        }
        shuffle()
    }
    
    mutating private func shuffle(){
        for i in 0..<numberOfCards{
            let randIndex = Int(arc4random_uniform(UInt32(numberOfCards-i)))+i
            (cards[i],cards[randIndex]) = (cards[randIndex],cards[i])
        }
    }
    
    mutating func showAllCards(){
        if numberOfHints != 0{
            numberOfHints -= 1
            for i in 0..<numberOfCards{
                if !cards[i].isMatched{
                    cards[i].isFaceUp = true
                }
            }
        }
    }
    
    mutating func hideAllCards(){
        for i in 0..<numberOfCards{
            if !cards[i].isMatched{
                cards[i].isFaceUp = false
            }
        }
    }
}

