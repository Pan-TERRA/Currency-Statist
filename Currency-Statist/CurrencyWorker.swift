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
import SwiftyUserDefaults

class CurrencyWorker {
	private let APIHost = "http://api.fixer.io/"
	private let baseSuffix = "?base="
	
	private let rates = "rates"
	private let date = "date"
	private let base = "base"
	
	open func fetchExchangeRates(from firstDate: Date, to lastDate: Date, withCompletionHandler handler:@escaping (([Currency], Error?) -> Void)) {
		let stringDates = strings(from: firstDate, to: lastDate)
		let fetchGroup = DispatchGroup()
		
		var fetchedCurrencies = [Currency]()
		var fetchError: Error? = nil
		
		for stringDate in stringDates {
			fetchGroup.enter()
			
			Alamofire.request(APIHost + stringDate + baseSuffix + "\(Defaults[.baseCurrencyType]!)", method: .get)
				.responseJSON { response in
					switch response.result {
					case .success(let value):
						let json = JSON(value)
						let date = DateFormatter.medium.date(from: json[self.date].string ?? "")
						let rates = json[self.rates]
						
						if let date = date {
							for (currencyTypeString, rate) in rates {
								if let currencyType = CurrencyType(rawValue: currencyTypeString) {
									let priceEntry = CurrencyPriceEntry(date: date, value: rate.double ?? 0.0)
									let existingCurrencies = fetchedCurrencies.filter { $0.type == currencyType }
									
									if existingCurrencies.isEmpty {
										let currency = Currency(type: currencyType)
										currency.append(priceEntry: priceEntry)
										fetchedCurrencies.append(currency)
									} else if let currency = existingCurrencies.first {
										currency.append(priceEntry: priceEntry)
									}
								}
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
	
	private func strings(from firstDate: Date, to lastDate: Date) -> [String] {
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
