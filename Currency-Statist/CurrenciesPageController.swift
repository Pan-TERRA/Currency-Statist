//
//  CurrenciesPageController.swift
//  Currency-Statist
//
//  Created by Nick Baidikoff on 2/19/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

class CurrenciesPageController: PageController {
	
	private let currencyCodes = ["USD", "EUR", "RUR", "CHF", "GBR", "PLZ", "SEK", "XAU", "CAD"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		menuBar.backgroundColor = UIColor.white.withAlphaComponent(0.9)
		menuBar.registerClass(CurrencyMenuCell.self)
		
		viewControllers = currencyCodes.map { code -> UIViewController in
			let viewController = SingleCurrencyViewController()
			viewController.currencyCode = code
			return viewController
		}
	}
}
