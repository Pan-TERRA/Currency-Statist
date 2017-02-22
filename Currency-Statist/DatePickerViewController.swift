//
//  DatePickerViewController.swift
//  DatePicker
//
//  Created by Nick Baidikoff on 2/22/17.
//  Copyright © 2017 Nick Baidikoff. All rights reserved.
//

import UIKit
import Foundation

@objc protocol DatePickerDelegate {
	
	/// Is called when user select new date
	///
	/// - parameter datePicker: The DatePicker VC
	/// - parameter date: The new date
	///
	func datePicker(_ datePicker: DatePickerViewController, didSelectDate date: Date?) -> Void
	
	/// Is called straight before the dismissing Date Picker VC
	///
	/// - parameter datePicker: The DatePicker VC
	///
	@objc optional func datePickerWillDismissViewController(_ datePicker: DatePickerViewController) -> Void
	
	/// Is called straight after the dismissing Date Picker VC
	///
	/// - parameter datePicker: The Date Picker VC
	///
	@objc optional func datePickerDidDismissViewController(_ datePicker: DatePickerViewController) -> Void
}

class DatePickerViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet weak var background: UIView! {
		didSet {
			background.layer.cornerRadius = pickerCornerRadius
			background.layer.borderColor = pickerBorderColor?.cgColor ?? mainColor.cgColor
			background.layer.borderWidth = pickerBorderWidth
		}
	}
	
	@IBOutlet weak var downSeparator: UIView! {
		didSet {
			downSeparator.backgroundColor = downSeparatorColor ?? mainColor
		}
	}
	
	@IBOutlet weak var middleSeparator: UIView! {
		didSet {
			middleSeparator.backgroundColor = middleSeparatorColor ?? mainColor
		}
	}
	
	@IBOutlet weak var confirm: UIButton! {
		didSet {
			confirm.setTitle(confirmButtonTitle, for: .normal)
			confirm.setTitleColor(confirmButtonColor ?? mainColor, for: .normal)
			confirm.setTitleColor(confirmButtonColor?.withAlphaComponent(0.7) ?? mainColor, for: .highlighted)
		}
	}
	
	@IBOutlet weak var cancel: UIButton! {
		didSet {
			cancel.setTitle(cancelButtonTitle, for: .normal)
			cancel.setTitleColor(cancelButtonColor ?? mainColor, for: .normal)
			cancel.setTitleColor(cancelButtonColor?.withAlphaComponent(0.7) ?? mainColor, for: .highlighted)
		}
	}
	
	@IBOutlet weak var datePicker: UIDatePicker! {
		didSet {
			datePicker.minimumDate = minimumDate
			datePicker.maximumDate = maximumDate
			datePicker.date = currentDate ?? Date()
			datePicker.setValue(datePickerTextColor ?? mainColor, forKey: "textColor")
			datePicker.setValue(false, forKey: "highlightsToday")
		}
	}
	
	// MARK: - Properties
	
	/// The maximum date of the date picker
	open var maximumDate: Date? {
		didSet {
			if let maximumDate = maximumDate, let minimumDate = minimumDate {
				if maximumDate.isLess(than: minimumDate) {
					self.maximumDate = oldValue
				} else {
					if datePicker != nil {
						datePicker.maximumDate = maximumDate
					}
				}
			}
		}
	}
	
	/// The minimum date of the date picker
	open var minimumDate: Date? {
		didSet {
			if let minimumDate = minimumDate, let maximumDate = maximumDate {
				if minimumDate.isGreater(than: maximumDate) {
					self.minimumDate = oldValue
				} else {
					if datePicker != nil {
						datePicker.minimumDate = minimumDate
					}
				}
			}
		}
	}
	
	/// The current date of the date picker
	/// This property is used to set date before showing date picker VC
	/// DO NOT pick date using this property. Use the delegate
	open var currentDate: Date? {
		didSet {
			if let currentDate = currentDate, let minimumDate = minimumDate, let maximumDate = maximumDate {
				if !currentDate.isGreaterOrEqual(than: minimumDate) && !currentDate.isLessOrEqual(than: maximumDate) {
					self.currentDate = oldValue
				} else {
					if datePicker != nil {
						datePicker.date = currentDate
					}
				}
			}
		}
	}
	
	/// The title of the confirm button
	open var confirmButtonTitle: String = "Confirm"
	
	/// The title of the cancel button
	open var cancelButtonTitle: String = "Cancel"
	
	/// The main color of the view controller
	/// Replaces any other not specified colors
	open var mainColor: UIColor = .black
	
	/// The color of the border of the date picker VC
	open var pickerBorderColor: UIColor?

	/// The color of the separator on the bottom of the date picker
	open var downSeparatorColor: UIColor?
	
	/// The color of the separator between cancel and confirm buttons
	open var middleSeparatorColor: UIColor?
	
	/// The color of the title of the confirm button
	open var confirmButtonColor: UIColor?
	
	/// The color of the title of the cancel button
	open var cancelButtonColor: UIColor?
	
	/// The color of the text in the date picker
	open var datePickerTextColor: UIColor?
	
	/// The border width of the picker backround view
	open var pickerBorderWidth: CGFloat = 1.0
	
	/// The corner radius of the picker background view
	open var pickerCornerRadius: CGFloat = 10.0
	
	/// The delegate of the date picker VC
	open var delegate: DatePickerDelegate?
	
	// MARK: - Init
	init() {
		super.init(nibName: nil, bundle: nil)
		modalPresentationStyle = .overCurrentContext
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// MARK: - VC Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(cancelTapGesture(gestureRecogniser:)))
		background.superview?.addGestureRecognizer(tapGestureRecogniser)
		
		let emptyGestureRecogniser = UITapGestureRecognizer(target: nil, action: nil)
		background.addGestureRecognizer(emptyGestureRecogniser)
	}
	
	// MARK: - Actions
	@IBAction func onConfirmTouchUpInside(_ sender: UIButton) {
		delegate?.datePicker(self, didSelectDate: datePicker.date)
		dismiss()
	}
	
	@IBAction func onCancelTouchUpInside(_ sender: UIButton) {
		dismiss()
	}
	
	// MARK: - Gesture recogniser
	func cancelTapGesture(gestureRecogniser: UITapGestureRecognizer) {
		dismiss()
	}
	
	func dismiss() {
		delegate?.datePickerWillDismissViewController?(self)
		dismiss(animated: true) {
			self.delegate?.datePickerDidDismissViewController?(self)
		}
	}
}
