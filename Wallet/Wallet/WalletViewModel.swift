//
//  WalletViewModel.swift
//  Wallet
//
//  Created by Débora Lage on 21/08/24.
//

import Foundation

class WalletViewModel: ObservableObject {
    
    var cards: [CardModel] = [
        CardModel(totalAmount: 1500075, validThrough: Date.from(year: 35, month: 12), name: "Name One", digits: "1234 1234 1234 1234"),
        CardModel(totalAmount: 750545, validThrough: Date.from(year: 25, month: 1), name: "Name Two", digits: "4321 4321 4321 4321"),
        CardModel(totalAmount: 250500, validThrough: Date.from(year: 30, month: 7), name: "Name Three", digits: "5678 5678 5678 5678")
    ]
    
}

extension Date {
    
    static func from(year: Int, month: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
}
