//
//  AppDelegate.swift
//  Currency-Statist
//
//  Created by Vlad Krut on 19.02.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import ChameleonFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {	
	var window: UIWindow?
	
	func applicationDidFinishLaunching(_ application: UIApplication) {
		setupDefaults()
	}
	
	func setupDefaults() {
		Defaults[.minimumDate] = NSCalendar.current.date(byAdding: .year, value: -4, to: Date())
		Defaults[.maximumDate] = Date()
		
		if Defaults[.startDate] == nil {
			Defaults[.startDate] = NSCalendar.current.date(byAdding: .month, value: -1, to: Date())
		}
		
		if Defaults[.finishDate] == nil {
			Defaults[.finishDate] = Date()
		}
		
		if Defaults[.baseCurrencyType] == nil {
			Defaults[.baseCurrencyType] = CurrencyType.usd.rawValue
		}

	}
}
