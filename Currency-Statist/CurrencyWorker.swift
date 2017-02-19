//
//  NetworkManager.swift
//  Currency-Statist
//
//  Created by Vlad Krut on 19.02.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrencyWorker {
	private let APIHost = "https://api.privatbank.ua/p24api/exchange_rates?json&date="
	
	private let exchangeRate = "exchangeRate"
	private let currency = "currency"
	private let date = "date"
	private let saleRateNB = "saleRateNB"
	private let purchaseRateNB = "purchaseRateNB"
	
	open func fetchExchangeRates(from firstDate: Date, to lastDate: Date, withCompletionHandler handler:@escaping (([Currency], Error?) -> Void)) {
		let stringDates = getStringsValue(from: firstDate, to: lastDate)
		let fetchGroup = DispatchGroup()
		
		var fetchedCurrencies = [Currency]()
		var fetchError: Error? = nil
		
		for stringDate in stringDates {
			fetchGroup.enter()
			
			Alamofire.request(APIHost + stringDate).responseJSON { response in
				switch response.result {
				case .success(let value):
					let responseJSON = JSON(value)
					let ratesJSON = responseJSON[self.exchangeRate]
										
					for (_, rateJSON) in ratesJSON {
						let type = CurrencyType(rawValue: rateJSON[self.currency].stringValue)
						
						if type != nil {
							var currentCurrency = Currency(type: type!)
							let thisTypeOfCurrency = fetchedCurrencies.filter { $0.type == type }
							if thisTypeOfCurrency.isEmpty {
								fetchedCurrencies.append(currentCurrency)
							} else if let first = thisTypeOfCurrency.first {
								currentCurrency = first
							}
							
							let formatter = DateFormatter()
							formatter.dateFormat = "dd.mm.yyyy"
							let date = formatter.date(from: responseJSON[self.date].stringValue)!
							
							let purchasePrice = rateJSON[self.purchaseRateNB].doubleValue
							let salePrice = rateJSON[self.saleRateNB].doubleValue
							
							currentCurrency.appendSalePriceWith(priceEntry: CurrencyPriceEntry(date: date, value: salePrice))
							currentCurrency.appendPurchasePriceWith(priceEntry: CurrencyPriceEntry(date: date, value: purchasePrice))
						}
					}
				case .failure(let error):
					fetchError = error
				}
				fetchGroup.leave()
			}
			
		}
		
		fetchGroup.notify(queue: .main) {
			handler(fetchedCurrencies, fetchError)
		}
	}
	
	private func getStringsValue(from firstDate: Date, to lastDate: Date) -> [String] {
		let calendar = NSCalendar.current
		let normalizedStartDate = calendar.startOfDay(for: firstDate)
		let normalizedLastDate = calendar.startOfDay(for: lastDate)
		
		var dates = [normalizedStartDate]
		var currentDate = normalizedStartDate
		
		while !calendar.isDate(currentDate, inSameDayAs: normalizedLastDate) {
			currentDate = calendar.date(byAdding:.day, value: 1, to: currentDate)!
			dates.append(currentDate)
		}
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd.mm.yyyy"
		
		return dates.map { dateFormatter.string(from: $0) }
		
	}
}
