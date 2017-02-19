//
//  CurrencyPriceSet.swift
//  Currency-Statist
//
//  Created by Vlad Krut on 19.02.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

class CurrencyPriceSet {
    
    private var prices: [CurrencyPriceEntry] = []
    
    subscript(index: Int) -> CurrencyPriceEntry {
        get {
            return prices[index]
        }
    }
    
    func appendWith(priceEntry entry: CurrencyPriceEntry) {
        prices.append(entry)
    }
    
}
