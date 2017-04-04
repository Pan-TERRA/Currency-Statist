//
//  SettingsViewController.swift
//  Currency-Statist
//
//  Created by Nick Baidikoff on 2/19/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

protocol SettingsUpdateDelegate {
	func settingsViewController(_ viewController: SettingsViewController, didUpdateStartDate startDate: Date) -> Void
	func settingsViewController(_ viewController: SettingsViewController, didUpdateFinishDate finishDate: Date) -> Void
	func settingsViewController(_ viewController: SettingsViewController, didUpdateBaseCurrencyType newType: CurrencyType) -> Void
}

class SettingsViewController: UITableViewController {
	open var delegate: SettingsUpdateDelegate?
	fileprivate var seletedIndexPath: IndexPath?
	
	open var startDate: Date? {
		didSet {
			if let startDate = startDate, startDate.isLess(than: finishDate ?? Date()) {
				delegate?.settingsViewController(self, didUpdateStartDate: startDate)
			}
		}
	}
	
	open var finishDate: Date? {
		didSet {
			if let finishDate = finishDate, finishDate.isGreater(than: startDate ?? Date()) {
				delegate?.settingsViewController(self, didUpdateFinishDate: finishDate)
			}
		}
	}
	
	fileprivate let currencyTypeMap = { () -> [String: CurrencyType] in
		var data = [String: CurrencyType]()
		for type in iterateEnum(CurrencyType.self) {
			data[NSLocalizedString(type.rawValue, comment: "")] = type
		}
		return data
	}()
	
	fileprivate let dateController = { () -> DatePickerViewController in
		let dateViewController = DatePickerViewController()
		dateViewController.mainColor = .flatBlack
		dateViewController.minimumDate = Defaults[.minimumDate]
		dateViewController.maximumDate = Defaults[.maximumDate]
		
		return dateViewController
	}()
	
	fileprivate let dataController = { () -> CustomDataPickerViewController in
		let dataViewController = CustomDataPickerViewController()
		
		var data: [String] = []
		for type in iterateEnum(CurrencyType.self) {
			data += [NSLocalizedString(type.rawValue, comment: "")]
		}
		
		dataViewController.data = data
		
		return dataViewController
	}()
	
	@IBOutlet weak var startDateLabel: UILabel! {
		didSet {
			if let startDate = startDate {
				startDateLabel.text = DateFormatter.mediumLocalized.string(from: startDate)
			}
		}
	}
	
	@IBOutlet weak var finishDateLabel: UILabel! {
		didSet {
			if let finishDate = finishDate {
				finishDateLabel.text = DateFormatter.mediumLocalized.string(from: finishDate)
			}
		}
	}
	
	@IBOutlet weak var baseCurrency: UILabel! {
		didSet {
			baseCurrency.text = NSLocalizedString(Defaults[.baseCurrencyType]!, comment: "")
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		dateController.delegate = self
		dataController.delegate = self
	}
}

// MARK: - UITableViewDelegate
extension SettingsViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		seletedIndexPath = indexPath
		
		if indexPath.section == 0 {
			if indexPath.row == 0 {
				dateController.currentDate = startDate ?? Date()
			} else {
				dateController.currentDate = finishDate ?? Date()
			}
			
			self.present(dateController, animated: true, completion: nil)
		} else {
			self.present(dataController, animated: true, completion: nil)
		}
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension SettingsViewController: DatePickerDelegate {
	func datePicker(_ datePicker: DatePickerViewController, didSelectDate date: Date?) {
		if let date = date {
			if seletedIndexPath?.row == 0 {
				startDate = date
				startDateLabel.text = DateFormatter.mediumLocalized.string(from: date)
			} else {
				finishDate = date
				finishDateLabel.text = DateFormatter.mediumLocalized.string(from: date)
			}
		}
	}
}

extension SettingsViewController: CustomDataPickerDelegate {
	func dataPicker(_ dataPicker: CustomDataPickerViewController, didSelectData data: String?) {
		if let data = data, let currencyType = currencyTypeMap[data] {
			baseCurrency.text = NSLocalizedString(currencyType.rawValue, comment: "")
			delegate?.settingsViewController(self, didUpdateBaseCurrencyType: currencyType)
		}
	}
}
