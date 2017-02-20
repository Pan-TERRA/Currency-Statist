//
//  Currency.swift
//  Currency-Statist
//
//  Created by Vlad Krut on 19.02.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

class Currency {
	var type: CurrencyType
	
	open var salePriceSet: CurrencyPriceSet {
		get {
			return salePrices
		}
	}
	
	private var salePrices = CurrencyPriceSet()
	
	func appendSalePriceWith(priceEntry entry: CurrencyPriceEntry) {
		salePrices.appendWith(priceEntry: entry)
	}
	
	init(type: CurrencyType) {
		self.type = type
	}
	
	func sort() {
		salePrices.sort()
	}
}
