//
//  WalletViewModel.swift
//  Wallet
//
//  Created by Débora Lage on 21/08/24.
//

import Foundation

class WalletViewModel: ObservableObject {
    
    var cards: [Card] = [
        Card(totalAmount: 1500075, 
             validThrough: Date.from(year: 35, month: 12),
             name: "Name One",
             digits: "1234 1234 1234 1234",
             transactions: [
                CardTransaction(isIncoming: false,
                                value: 10356,
                                description: "Amazon",
                                date: Date.from(year: 2024, month: 05, day: 24)),
                CardTransaction(isIncoming: true,
                                value: 100097,
                                description: "Apple", 
                                date: Date.from(year: 2024, month: 05, day: 24)),
             ]),
        Card(totalAmount: 750545,
             validThrough: Date.from(year: 25, month: 1),
             name: "Name Two",
             digits: "4321 4321 4321 4321",
             transactions: [
                CardTransaction(isIncoming: false,
                                value: 10356,
                                description: "Amazon",
                                date: Date.from(year: 2024, month: 05, day: 24)),
                CardTransaction(isIncoming: true,
                                value: 100097,
                                description: "Apple",
                                date: Date.from(year: 2024, month: 05, day: 24)),
             ]),
        Card(totalAmount: 250500,
             validThrough: Date.from(year: 30, month: 7),
             name: "Name Three",
             digits: "5678 5678 5678 5678",
             transactions: [
                CardTransaction(isIncoming: false,
                                value: 10356,
                                description: "Amazon",
                                date: Date.from(year: 2024, month: 05, day: 24)),
                CardTransaction(isIncoming: true,
                                value: 100097,
                                description: "Apple",
                                date: Date.from(year: 2024, month: 05, day: 24)),
             ])
    ]
    
}

extension Date {
    
    static func from(year: Int, month: Int, day: Int = 1) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
}
