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
		case .usd: return NSLocalizedString("United States Dollar", comment: "")
		case .eur: return NSLocalizedString("Euro", comment: "")
		case .rub: return NSLocalizedString("Russian Rubble", comment: "")
		case .chf: return NSLocalizedString("Swiss Franc", comment: "")
		case .gbp: return NSLocalizedString("British Pound", comment: "")
		case .plz: return NSLocalizedString("Polish Zloty", comment: "")
		case .sek: return NSLocalizedString("Swedish Krona", comment: "")
		case .cad: return NSLocalizedString("Canadian Dollar", comment: "")
		}
	}
	
	static let types: [CurrencyType] = [.usd, .eur, .rub, .chf, .gbp, .plz, .sek, .cad]
}
