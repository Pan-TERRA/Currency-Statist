//
//  UIKit+CurrencyStatist.swift
//  Currency-Statist
//
//  Created by Nick Baidikoff on 2/22/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

extension Date {
	func isGreater(thanDate dateToCompare: Date) -> Bool {
		return self.compare(dateToCompare) == .orderedDescending
	}
	
	func isLess(thanDate dateToCompare: Date) -> Bool {
		return self.compare(dateToCompare) == .orderedAscending
	}
}
