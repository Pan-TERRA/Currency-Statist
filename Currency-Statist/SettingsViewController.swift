//
//  SettingsViewController.swift
//  Currency-Statist
//
//  Created by Nick Baidikoff on 2/19/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

protocol SettingsUpdateDelegate {
	func settingsViewController(_ viewController: SettingsViewController, didUpdateStartDate startDate: Date?) -> Void
	func settingsViewController(_ viewController: SettingsViewController, didUpdateFinishDate finishDate: Date?) -> Void
}

class SettingsViewController: UIViewController {
	open var delegate: SettingsUpdateDelegate?
	
	private var startDate: Date? {
		didSet {
			delegate?.settingsViewController(self, didUpdateStartDate: startDate)
		}
	}
	
	private var finishDate: Date? {
		didSet {
			delegate?.settingsViewController(self, didUpdateFinishDate: finishDate)
		}
	}
	
	open var loadedStartDate: Date?
	open var loadedFinishDate: Date?
	
	@IBOutlet weak var startDatePicker: UIDatePicker! {
		didSet {
			startDatePicker.maximumDate = Date()
			startDatePicker.date = loadedStartDate ?? Date()
		}
	}
	
	@IBOutlet weak var finishDatePicker: UIDatePicker! {
		didSet {
			finishDatePicker.maximumDate = Date()
			finishDatePicker.date = loadedFinishDate ?? Date()
		}
	}
	
	@IBAction func startDatePickerValueDidChanged(_ sender: UIDatePicker) {
		startDate = sender.date
	}
	
	@IBAction func finishDateValueDidChanged(_ sender: UIDatePicker) {
		finishDate = sender.date
	}
}
