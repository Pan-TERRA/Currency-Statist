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

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    static let APIHost = "https://api.privatbank.ua/p24api/exchange_rates?json&date="
    
    struct NetworkManagerConstants {
        static let exchangeRate = "exchangeRate"
        static let currency = "currency"
        static let date = "date"
        static let saleRateNB = "saleRateNB"
        static let purchaseRateNB = "purchaseRateNB"
    }
    
    func fetchExchangeRates(from firstDate: Date, to lastDate: Date, withCompletionHandler handler:(([Currency]) -> Void)) {
        
        let stringDates = getStringsValueOfDates(from: firstDate, to: lastDate)
        
        var fetchedCurrencies = [Currency]()
        
        let fetchGroup = DispatchGroup()
        
        for stringDate in stringDates {
            
            fetchGroup.enter()
            Alamofire.request(NetworkManager.APIHost + stringDate).responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    let responseJSON = JSON(value)
                    
                    let ratesJSON = responseJSON[NetworkManagerConstants.exchangeRate]
                    
                    //TODO: снести всё это гавно
                    
                    for (_, rateJSON) in ratesJSON {
                        var currentCurrency: Currency
                        switch rateJSON[NetworkManagerConstants.currency].stringValue {
                        case "USD":
                            let thisTypeOfCurrency = fetchedCurrencies.filter({ $0.type == .USD })
                            if thisTypeOfCurrency.isEmpty {
                                currentCurrency = Currency(type: .USD)
                                fetchedCurrencies.append(currentCurrency)
                            } else {
                                currentCurrency = thisTypeOfCurrency[0]
                            }
                            
                        case "EUR":
                            let thisTypeOfCurrency = fetchedCurrencies.filter({ $0.type == .EUR })
                            if thisTypeOfCurrency.isEmpty {
                                currentCurrency = Currency(type: .EUR)
                                fetchedCurrencies.append(currentCurrency)
                            } else {
                                currentCurrency = thisTypeOfCurrency[0]
                            }
                            
                        case "RUS":
                            let thisTypeOfCurrency = fetchedCurrencies.filter({ $0.type == .RUS })
                            if thisTypeOfCurrency.isEmpty {
                                currentCurrency = Currency(type: .RUS)
                                fetchedCurrencies.append(currentCurrency)
                            } else {
                                currentCurrency = thisTypeOfCurrency[0]
                            }
                            
                        case "CHF":
                            let thisTypeOfCurrency = fetchedCurrencies.filter({ $0.type == .CHF })
                            if thisTypeOfCurrency.isEmpty {
                                currentCurrency = Currency(type: .CHF)
                                fetchedCurrencies.append(currentCurrency)
                            } else {
                                currentCurrency = thisTypeOfCurrency[0]
                            }
                            
                        case "GBR":
                            let thisTypeOfCurrency = fetchedCurrencies.filter({ $0.type == .GBR })
                            if thisTypeOfCurrency.isEmpty {
                                currentCurrency = Currency(type: .GBR)
                                fetchedCurrencies.append(currentCurrency)
                            } else {
                                currentCurrency = thisTypeOfCurrency[0]
                            }
                            
                        case "PLZ":
                            let thisTypeOfCurrency = fetchedCurrencies.filter({ $0.type == .PLZ })
                            if thisTypeOfCurrency.isEmpty {
                                currentCurrency = Currency(type: .PLZ)
                                fetchedCurrencies.append(currentCurrency)
                            } else {
                                currentCurrency = thisTypeOfCurrency[0]
                            }
                            
                        case "SEK":
                            let thisTypeOfCurrency = fetchedCurrencies.filter({ $0.type == .SEK })
                            if thisTypeOfCurrency.isEmpty {
                                currentCurrency = Currency(type: .SEK)
                                fetchedCurrencies.append(currentCurrency)
                            } else {
                                currentCurrency = thisTypeOfCurrency[0]
                            }
                            
                        case "XAU":
                            let thisTypeOfCurrency = fetchedCurrencies.filter({ $0.type == .XAU })
                            if thisTypeOfCurrency.isEmpty {
                                currentCurrency = Currency(type: .XAU)
                                fetchedCurrencies.append(currentCurrency)
                            } else {
                                currentCurrency = thisTypeOfCurrency[0]
                            }
                            
                        case "CAD":
                            let thisTypeOfCurrency = fetchedCurrencies.filter({ $0.type == .CAD })
                            if thisTypeOfCurrency.isEmpty {
                                currentCurrency = Currency(type: .CAD)
                                fetchedCurrencies.append(currentCurrency)
                            } else {
                                currentCurrency = thisTypeOfCurrency[0]
                            }
                            
                        default: currentCurrency = Currency(type: .USD) //TODO: Костыль
                        }
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd.mm.yyyy"
                        let date = formatter.date(from: responseJSON[NetworkManagerConstants.date].stringValue)!
                        
                        let purchasePrice = rateJSON[NetworkManagerConstants.purchaseRateNB].doubleValue
                        let salePrice = rateJSON[NetworkManagerConstants.saleRateNB].doubleValue
                        
                        currentCurrency.appendSalePriceWith(priceEntry: CurrencyPriceEntry(date: date, value: salePrice))
                        currentCurrency.appendPurchasePriceWith(priceEntry: CurrencyPriceEntry(date: date, value: purchasePrice))
                    }
                    
                case .failure(let error):
                    print(error)
                }
                fetchGroup.leave()
            }
        }
        fetchGroup.wait()
        handler(fetchedCurrencies)
    }
    
    func getStringsValueOfDates(from firstDate: Date, to lastDate: Date) -> [String] {
        
        let calendar = NSCalendar.current
        let normalizedStartDate = calendar.startOfDay(for: firstDate)
        let normalizedLastDate = calendar.startOfDay(for: lastDate)
        
        var dates = [normalizedStartDate]
        var currentDate = normalizedStartDate
        
        repeat {
            currentDate = calendar.date(byAdding:Calendar.Component.day, value: 1, to: currentDate)!
            dates.append(currentDate)
        } while !calendar.isDate(currentDate, inSameDayAs: normalizedLastDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.mm.yyyy"
        
        return dates.map({ dateFormatter.string(from: $0) })
        
    }
}
