//
//  Currency.swift
//  Currency-Statist
//
//  Created by Vlad Krut on 19.02.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

class Currency {
    
    enum CurrencyType : String {
        case USD = "USD"
        case EUR = "EUR"
        case RUS = "RUS"
        case CHF = "CHF"
        case GBR = "GBR"
        case PLZ = "PLZ"
        case SEK = "SEK"
        case XAU = "XAU"
        case CAD = "CAD"
        
        var description: String {
            
            switch self {
            case .USD: return "Доллар США"
            case .EUR: return "Евро"
            case .RUS: return "Российский рубль"
            case .CHF: return "Швейцарский франк"
            case .GBR: return "Британский фунт"
            case .PLZ: return "Польский злотый"
            case .SEK: return "Шведская крона"
            case .XAU: return "Золото"
            case .CAD: return "Канадский доллар"
            }
            
        }
        
    }
    
    var type: CurrencyType
    
    private var salePrices = CurrencyPriceSet()
    private var purchasePrices = CurrencyPriceSet()
    
    func appendSalePriceWith(priceEntry entry: CurrencyPriceEntry) {
        salePrices.appendWith(priceEntry: entry)
    }
    
    func appendPurchasePriceWith(priceEntry entry: CurrencyPriceEntry) {
        purchasePrices.appendWith(priceEntry: entry)
    }
    
    init(type: CurrencyType) {
        self.type = type
    }
    
}
