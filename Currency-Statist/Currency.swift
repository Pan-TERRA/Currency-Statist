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
	
	open var purchasePriceSet: CurrencyPriceSet {
		get {
			return purchasePrices
		}
	}
	
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
