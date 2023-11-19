//
//  Card.swift
//  Laba
//
//  Created by   Павел Недобежкин on 23.10.2023.
//

import Foundation

struct Card: Hashable{
    var hashValue: Int{
        return ID
    }
    static func == (lhs: Card, rhs: Card)->Bool{
        return lhs.ID == rhs.ID
    }
    var isFaceUp = false
    var isMatched = false
    private var ID: Int
    
    static private var IDFactory = 0
    
    static private func getUniqID()->Int{
        Card.IDFactory+=1
        return Card.IDFactory
    }
    
    init(){
        self.ID = Card.getUniqID()
    }
    
}
