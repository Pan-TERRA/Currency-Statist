//
//  Currency.swift
//  Currency-Statist
//
//  Created by Vlad Krut on 19.02.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

class Currency {
	let type: CurrencyType
	
	open var salePriceSet: CurrencyPriceSet { return salePrices }
	private let salePrices = CurrencyPriceSet()
	
	init(type: CurrencyType) {
		self.type = type
	}
	
	func appendSalePriceWith(priceEntry entry: CurrencyPriceEntry) {
		salePrices.appendWith(priceEntry: entry)
	}
		
	func sort() {
		salePrices.sort()
	}
}
