//
//  Card.swift
//  ConcentrationGame
//
//  Created by Max on 7/25/20.
//  Copyright © 2020 Max. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
//    var hashValue: Int{
//        return self.identifier
//    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    static func == (left: Card, right: Card)->Bool{
        return left.identifier == right.identifier
    }
    
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
