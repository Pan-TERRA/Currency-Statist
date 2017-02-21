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
	case eur = "EUR"
	case rub = "RUB"
	case chf = "CHF"
	case gbp = "GBP"
	case plz = "PLZ"
	case sek = "SEK"
	case cad = "CAD"
	
	var description: String {
		switch self {
		case .usd: return "United States Dollar"
		case .eur: return "Euro"
		case .rub: return "Russian Rubble"
		case .chf: return "Swiss Franc"
		case .gbp: return "British Pound"
		case .plz: return "Polish Zloty"
		case .sek: return "Swedish Krona"
		case .cad: return "Canadian Dollar"
		}
	}
	
	static let types: [CurrencyType] = [.usd, .eur, .rub, .chf, .gbp, .plz, .sek, .cad]
}
