//
//  Foundation+CurrencyStatist.swift
//  Currency Statist
//
//  Created by Nick Baidikoff on 3/10/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

extension DateFormatter {
	public static let shortLocalized: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .short
		return formatter
	}()

	public static let mediumLocalized: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		return formatter
	}()
	
	public static let medium: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()
}
