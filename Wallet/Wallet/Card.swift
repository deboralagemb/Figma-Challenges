//
//  CardModel.swift
//  Wallet
//
//  Created by Débora Lage on 21/08/24.
//

import Foundation

struct Card {
    var totalAmount: Int
    var validThrough: Date
    var name: String
    var digits: String
    var transactions: [CardTransaction]
}
