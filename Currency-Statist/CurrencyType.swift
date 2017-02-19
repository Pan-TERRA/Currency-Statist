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
		case .usd: return "Доллар США"
		case .eur: return "Евро"
		case .rub: return "Российский рубль"
		case .chf: return "Швейцарский франк"
		case .gbp: return "Британский фунт"
		case .plz: return "Польский злотый"
		case .sek: return "Шведская крона"
		case .cad: return "Канадский доллар"
		}
	}
	
	static let values = ["USD", "EUR", "RUB", "CHF", "GBP", "PLZ", "SEK", "CAD"]
	static let codes = ["Доллар США", "Евро", "Российский рубль", "Швейцарский франк", "Британский фунт", "Польский злотый", "Шведская крона", "Канадский доллар"]
}
