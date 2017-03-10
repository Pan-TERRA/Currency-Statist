//
//  UIKit+CurrencyStatist.swift
//  Currency-Statist
//
//  Created by Nick Baidikoff on 2/22/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

extension Date {
	func isGreater(than dateToCompare: Date) -> Bool {
		return NSCalendar.current.compare(self, to: dateToCompare, toGranularity: .day) == .orderedDescending
	}
	
	func isLess(than dateToCompare: Date) -> Bool {
		return NSCalendar.current.compare(self, to: dateToCompare, toGranularity: .day) == .orderedAscending
	}
	
	func isGreaterOrEqual(than dateToCompare: Date) -> Bool {
		return NSCalendar.current.compare(self, to: dateToCompare, toGranularity: .day) != .orderedAscending
	}
	
	func isLessOrEqual(than dateToCompare: Date) -> Bool {
		return NSCalendar.current.compare(self, to: dateToCompare, toGranularity: .day) != .orderedDescending
	}
	
	func isEqual(to dateToCompare: Date) -> Bool {
		return NSCalendar.current.compare(self, to: dateToCompare, toGranularity: .day) == .orderedSame
	}
}
