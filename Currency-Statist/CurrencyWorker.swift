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
							let existingCurrency = fetchedCurrencies.filter { $0.type == type }
							if existingCurrency.isEmpty {
								fetchedCurrencies.append(currentCurrency)
							} else if let first = existingCurrency.first {
								currentCurrency = first
							}
							
							let date = DateFormatter.medium.date(from: responseJSON[self.date].stringValue)!
							let salePrice = rateJSON[self.saleRateNB].doubleValue
							currentCurrency.appendSalePriceWith(priceEntry: CurrencyPriceEntry(date: date, value: salePrice))
						}
					}
				case .failure(let error):
					fetchError = error
				}
				fetchGroup.leave()
			}
			
		}
		
		fetchGroup.notify(queue: .main) {
			fetchedCurrencies = fetchedCurrencies.map { $0.sort(); return $0 }
			handler(fetchedCurrencies, fetchError)
		}
	}
	
	private func getStringsValue(from firstDate: Date, to lastDate: Date) -> [String] {
		let startDate = NSCalendar.current.startOfDay(for: firstDate)
		let finishDate = NSCalendar.current.startOfDay(for: lastDate)
		
		
		var dates = [DateFormatter.medium.string(from: startDate)]
		var currentDate = startDate
		
		while !NSCalendar.current.isDate(currentDate, inSameDayAs: finishDate) {
			currentDate = NSCalendar.current.date(byAdding:.day, value: 1, to: currentDate)!
			dates.append(DateFormatter.medium.string(from: currentDate))
		}
		
		return dates
	}
}
