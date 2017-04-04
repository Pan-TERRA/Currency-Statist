//
//  Currency.swift
//  Currency-Statist
//
//  Created by Vlad Krut on 19.02.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

class Currency {
	private let salePrices = CurrencyPriceSet()
	
	open let type: CurrencyType
	open var salePriceSet: CurrencyPriceSet { return salePrices }

	init(type: CurrencyType) {
		self.type = type
	}
	
	func append(priceEntry entry: CurrencyPriceEntry) {
		salePrices.append(withPriceEntry: entry)
	}
		
	func sort() {
		salePrices.sort()
	}
}
