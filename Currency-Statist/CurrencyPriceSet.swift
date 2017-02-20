//
//  CurrencyPriceSet.swift
//  Currency-Statist
//
//  Created by Vlad Krut on 19.02.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import Charts

class CurrencyPriceSet {
	open var priceValues: [CurrencyPriceEntry] {
		get {
			return prices
		}
	}
	
	private var prices: [CurrencyPriceEntry] = []
	
	subscript(index: Int) -> CurrencyPriceEntry {
		get {
			return prices[index]
		}
	}
	
	func appendWith(priceEntry entry: CurrencyPriceEntry) {
		prices.append(entry)
	}
	
	func sort() {
		prices.sort { return $0.date < $1.date }
	}
}
