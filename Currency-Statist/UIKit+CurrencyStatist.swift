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
		return self.compare(dateToCompare) == .orderedDescending
	}
	
	func isLess(than dateToCompare: Date) -> Bool {
		return self.compare(dateToCompare) == .orderedAscending
	}
	
	func isEqual(to dateToCompare: Date) -> Bool {
		return self.compare(dateToCompare) == .orderedSame
	}
}
