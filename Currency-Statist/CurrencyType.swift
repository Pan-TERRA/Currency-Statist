//
//  CurrencyType.swift
//  Currency-Statist
//
//  Created by Nick Baidikoff on 2/19/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

enum CurrencyType : String {
	case usd = "USD"
	case jpy = "JPY"
	case bgn = "BGN"
	case czk = "CZK"
	case dkk = "DKK"
	case gbp = "GBP"
	case huf = "HUF"
	case pln = "PLN"
	case ron = "RON"
	case sek = "SEK"
	case chf = "CHF"
	case nok = "NOK"
	case hrk = "HRK"
	case rub = "RUB"
	case `try` = "TRY"
	case aud = "AUD"
	case brl = "BRL"
	case cad = "CAD"
	case cny = "CNY"
	case hkd = "HKD"
	case idr = "IDR"
	case ils = "ILS"
	case inr = "INR"
	case krw = "KRW"
	case mxn = "MXN"
	case myr = "MYR"
	case nzd = "NZD"
	case php = "PHP"
	case sgd = "SGD"
	case thb = "THB"
	case zar = "ZAR"
	
	var description: String {
		return NSLocalizedString(self.rawValue, comment: "")
	}
}
