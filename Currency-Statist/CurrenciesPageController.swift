//
//  CurrenciesPageController.swift
//  Currency-Statist
//
//  Created by Nick Baidikoff on 2/19/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit
import ChameleonFramework
import SwiftyUserDefaults
import PKHUD

class CurrenciesPageController: PageController {
	fileprivate let worker = CurrencyWorker()
	
	fileprivate var startDate: Date?
	fileprivate var finishDate: Date?
	fileprivate var isDateChanged = false
	
	fileprivate var currencies: [Currency]? {
		didSet {
			let _ = viewControllers.map { viewController  -> SingleCurrencyViewController in
				let singleCurrencyVC = viewController as! SingleCurrencyViewController
				singleCurrencyVC.currency = currencies?.filter { $0.type == singleCurrencyVC.type }.first
				return singleCurrencyVC
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.hidesNavigationBarHairline = true
		navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.flatWhite]
		navigationController?.navigationBar.tintColor = .flatWhite
		navigationController?.navigationBar.barTintColor = .flatOrange
		navigationController?.navigationBar.isTranslucent = false
		
		finishDate = Defaults[.finishDate]
		startDate = Defaults[.startDate]
		
		menuBar.backgroundColor = UIColor.white.withAlphaComponent(0.9)
		menuBar.registerClass(CurrencyMenuCell.self)
		menuBar.frame = CGRect(x: 0.0, y: 0.0, width: 375.0, height: 44.0)
		
		viewControllers = CurrencyType.types.map { SingleCurrencyViewController(type: $0) }
		
		scrollView.isPagingEnabled = false
		scrollView.isScrollEnabled = false
		
		updateData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if isDateChanged {
			updateData()
			isDateChanged = false
		}
	}
	
	@IBAction func onSettingsButtonTap(_ sender: UIBarButtonItem) {
		performSegue(withIdentifier: toSettingsSegue, sender: self)
	}
	
	private let toSettingsSegue = "toSettingsSegue"
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let identifier = segue.identifier, identifier == toSettingsSegue {
			let destinationVC = segue.destination as! SettingsViewController
			destinationVC.delegate = self
			destinationVC.startDate = startDate
			destinationVC.finishDate = finishDate
		}
	}
	
	fileprivate func updateData() {
		if let startDate = startDate, let finishDate = finishDate, startDate.isLess(than: finishDate) {
			HUD.show(.progress)
			worker.fetchExchangeRates(from: startDate, to: finishDate) { currency, error in
				HUD.hide()
				if let error = error {
					let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
					self.present(alert, animated: true, completion: nil)
					HUD.flash(.error, delay: 1.0)
				} else {
					self.currencies = currency
					HUD.flash(.success, delay: 1.0)
				}
			}
		}
	}
}

extension CurrenciesPageController: SettingsUpdateDelegate {
	func settingsViewController(_ viewController: SettingsViewController, didUpdateStartDate startDate: Date) {
		if let current = self.startDate, !current.isEqual(to: startDate) {
			Defaults[.startDate] = startDate
			self.startDate = startDate
			self.isDateChanged = true
		}
	}
	
	func settingsViewController(_ viewController: SettingsViewController, didUpdateFinishDate finishDate: Date) {
		if let current = self.finishDate, !current.isEqual(to: finishDate) {
			Defaults[.finishDate] = finishDate
			self.finishDate = finishDate
			self.isDateChanged = true
		}
	}
}
