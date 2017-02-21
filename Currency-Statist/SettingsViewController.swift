//
//  SettingsViewController.swift
//  Currency-Statist
//
//  Created by Nick Baidikoff on 2/19/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

protocol SettingsUpdateDelegate {
    func settingsViewController(_ viewController: SettingsViewController, didUpdateDates: (startDate: Date, finishDate: Date)) -> Void
}

class SettingsViewController: UIViewController {
	open var delegate: SettingsUpdateDelegate?
	
	private var startDate: Date = UserDefaults.standard.startDate {
		didSet {
			needReloadData = true
		}
	}
	
	private var finishDate: Date = UserDefaults.standard.finishDate {
		didSet {
			needReloadData = true
		}
	}
    
    private var needReloadData = false
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if needReloadData {
            delegate?.settingsViewController(self, didUpdateDates: (startDate, finishDate))
            UserDefaults.standard.startDate = startDate
            UserDefaults.standard.finishDate = finishDate
            needReloadData = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startDatePicker.date = UserDefaults.standard.startDate
        finishDatePicker.date = UserDefaults.standard.finishDate
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
