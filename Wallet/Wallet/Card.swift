//
//  CardModel.swift
//  Wallet
//
//  Created by Débora Lage on 21/08/24.
//

import Foundation

struct Card: Hashable, Equatable {
    var totalAmount: Int
    var validThrough: Date
    var name: String
    var digits: String
    var transactions: [CardTransaction]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(totalAmount)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
