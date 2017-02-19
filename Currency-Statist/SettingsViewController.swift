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
	
	open var loadedStartDate: Date? {
		didSet {
			if let loadedStartDate = loadedStartDate {
				startDatePicker.date = loadedStartDate
			}
		}
	}
	
	open var loadedFinishDate: Date? {
		didSet {
			if let loadedFinishDate = loadedFinishDate {
				finishDatePicker.date = loadedFinishDate
			}
		}
	}
	
	@IBOutlet weak var startDatePicker: UIDatePicker! {
		didSet {
			startDatePicker.maximumDate = Date()
		}
	}
	
	@IBOutlet weak var finishDatePicker: UIDatePicker! {
		didSet {
			finishDatePicker.maximumDate = Date()
		}
	}
	
	@IBAction func startDatePickerValueDidChanged(_ sender: UIDatePicker) {
		startDate = sender.date
	}
	
	@IBAction func finishDateValueDidChanged(_ sender: UIDatePicker) {
		finishDate = sender.date
	}
}
