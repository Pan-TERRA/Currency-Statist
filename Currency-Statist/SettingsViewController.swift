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
	func settingsViewController(_ viewController: SettingsViewController, didUpdateStartDate startDate: Date?) -> Void
	func settingsViewController(_ viewController: SettingsViewController, didUpdateFinishDate finishDate: Date?) -> Void
}

class SettingsViewController: UITableViewController {
	open var delegate: SettingsUpdateDelegate?
	fileprivate var seletedIndexPath: IndexPath?
	
	open var startDate: Date? {
		didSet {
			if let startDate = startDate, startDate.isLess(thanDate: finishDate ?? Date()) {
				delegate?.settingsViewController(self, didUpdateStartDate: startDate)
			}
		}
	}
	
	open var finishDate: Date? {
		didSet {
			if let finishDate = finishDate, finishDate.isGreater(thanDate: startDate ?? Date()) {
				delegate?.settingsViewController(self, didUpdateFinishDate: finishDate)
			}
		}
	}
	
	fileprivate let formatter = { () -> DateFormatter in
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy"
		return formatter
	}()
	
	fileprivate let dateController = { () -> DateTimePickerViewController in 
		let dateViewController = DateTimePickerViewController()
		dateViewController.selectedtype = DateType
		dateViewController.mainColor = .flatWhite
		dateViewController.minDate = Defaults[.minimumDate]
		dateViewController.maxDate = Defaults[.maximumDate]

		return dateViewController
	}()
	
	@IBOutlet weak var startDateLabel: UILabel! {
		didSet {
			if let startDate = startDate {
				startDateLabel.text = formatter.string(from: startDate)
			}
		}
	}
	
	@IBOutlet weak var finishDateLabel: UILabel! {
		didSet {
			if let finishDate = finishDate {
				finishDateLabel.text = formatter.string(from: finishDate)
			}
		}
	}
}

// MARK: - UITableViewDelegate
extension SettingsViewController {
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		dateController.delegate = self
		seletedIndexPath = indexPath

		if indexPath.row == 0 {
			dateController.date = startDate ?? Date()
		} else {
			dateController.date = finishDate ?? Date()
		}
		
		self.present(dateController, animated: true, completion: nil)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension SettingsViewController: DatePickerViewControllerDelegate {
	func datePickerPickedDate(_ date: Date!) {
		if seletedIndexPath?.row == 0 {
			startDate = date
			startDateLabel.text = formatter.string(from: date)
		} else {
			finishDate = date
			finishDateLabel.text = formatter.string(from: date)
		}
	}
}
