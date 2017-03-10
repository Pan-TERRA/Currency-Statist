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
	
	fileprivate let dateController = { () -> DatePickerViewController in
		let dateViewController = DatePickerViewController()
		dateViewController.mainColor = .flatBlack
		dateViewController.minimumDate = Defaults[.minimumDate]
		dateViewController.maximumDate = Defaults[.maximumDate]
		
		return dateViewController
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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		dateController.delegate = self
	}
}

// MARK: - UITableViewDelegate
extension SettingsViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		seletedIndexPath = indexPath
		
		if indexPath.row == 0 {
			dateController.currentDate = startDate ?? Date()
		} else {
			dateController.currentDate = finishDate ?? Date()
		}
		
		self.present(dateController, animated: true, completion: nil)
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
