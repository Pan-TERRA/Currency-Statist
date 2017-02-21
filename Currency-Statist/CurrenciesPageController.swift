//
//  CurrenciesPageController.swift
//  Currency-Statist
//
//  Created by Nick Baidikoff on 2/19/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit
import ChameleonFramework

class CurrenciesPageController: PageController {
	fileprivate let worker = CurrencyWorker()
	
	fileprivate var currencies: [Currency]? {
		didSet {
			let _ = viewControllers.map { viewController  -> SingleCurrencyViewController in
				let singleCurrencyVC = viewController as! SingleCurrencyViewController
				singleCurrencyVC.currency = currencies?.filter { $0.type == singleCurrencyVC.type }.first
				return singleCurrencyVC
			}
		}
	}
	
	fileprivate var startDate: Date? {
		didSet {
			updateData()
		}
	}
	
	fileprivate var finishDate: Date? {
		didSet {
			updateData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.navigationBar.barTintColor = .flatOrange
		navigationController?.navigationBar.tintColor = .flatWhite
		navigationController?.hidesNavigationBarHairline = true
		
		finishDate = Date()
		startDate = NSCalendar.current.date(byAdding: .month, value: -1, to: finishDate!)
		
		menuBar.backgroundColor = UIColor.white.withAlphaComponent(0.9)
		menuBar.registerClass(CurrencyMenuCell.self)
		
		viewControllers = CurrencyType.types.map { SingleCurrencyViewController(type: $0) }
	}
	
	@IBAction func onSettingsButtonTap(_ sender: UIBarButtonItem) {
		performSegue(withIdentifier: toSettingsSegue, sender: self)
	}
	
	private let toSettingsSegue = "toSettingsSegue"
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let identifier = segue.identifier, identifier == toSettingsSegue {
			let destinationVC = segue.destination as! SettingsViewController
			destinationVC.delegate = self
			destinationVC.loadedStartDate = startDate
			destinationVC.loadedFinishDate = finishDate
		}
	}
	
	private func updateData() {
		if let startDate = startDate, let finishDate = finishDate, startDate.compare(finishDate) == .orderedAscending {
			worker.fetchExchangeRates(from: startDate, to: finishDate) { currency, error in
				if let error = error {
					let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
					self.present(alert, animated: true, completion: nil)
				} else {
					self.currencies = currency
				}
			}
		}
	}
}

extension CurrenciesPageController: SettingsUpdateDelegate {
	func settingsViewController(_ viewController: SettingsViewController, didUpdateStartDate startDate: Date?) {
		self.startDate = startDate
	}
	
	func settingsViewController(_ viewController: SettingsViewController, didUpdateFinishDate finishDate: Date?) {
		self.finishDate = finishDate
	}
}
