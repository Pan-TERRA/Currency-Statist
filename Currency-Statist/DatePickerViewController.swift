//
//  DatePickerViewController.swift
//  DatePicker
//
//  Created by Nick Baidikoff on 2/22/17.
//  Copyright © 2017 Nick Baidikoff. All rights reserved.
//

import UIKit
import Foundation

@objc public protocol DatePickerDelegate {
	
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

public class DatePickerViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet weak var background: UIView! {
		didSet {
			background.layer.cornerRadius = pickerCornerRadius
			background.layer.borderColor = (pickerBorderColor ?? mainColor).cgColor
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
			confirm.setTitleColor((confirmButtonColor ?? mainColor).withAlphaComponent(0.7), for: .highlighted)
		}
	}
	
	@IBOutlet weak var cancel: UIButton! {
		didSet {
			cancel.setTitle(cancelButtonTitle, for: .normal)
			cancel.setTitleColor(cancelButtonColor ?? mainColor, for: .normal)
			cancel.setTitleColor((cancelButtonColor ?? mainColor).withAlphaComponent(0.7), for: .highlighted)
		}
	}
	
	@IBOutlet weak var datePicker: UIDatePicker! {
		didSet {
			datePicker.minimumDate = minimumDate
			datePicker.maximumDate = maximumDate
			datePicker.date = currentDate ?? Date()
		}
	}
	
	// MARK: - Properties
	
	/// The maximum date of the date picker
	public var maximumDate: Date? {
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
	public var minimumDate: Date? {
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
	public var currentDate: Date? {
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
	public var confirmButtonTitle: String = NSLocalizedString("Confirm", comment: "")
	
	/// The title of the cancel button
	public var cancelButtonTitle: String = NSLocalizedString("Cancel", comment: "")
	
	/// The main color of the view controller
	/// Replaces any other not specified colors
	public var mainColor: UIColor = .black
	
	/// The color of the border of the date picker VC
	public var pickerBorderColor: UIColor?

	/// The color of the separator on the bottom of the date picker
	public var downSeparatorColor: UIColor?
	
	/// The color of the separator between cancel and confirm buttons
	public var middleSeparatorColor: UIColor?
	
	/// The color of the title of the confirm button
	public var confirmButtonColor: UIColor?
	
	/// The color of the title of the cancel button
	public var cancelButtonColor: UIColor?
	
	/// The color of the text in the date picker
	public var datePickerTextColor: UIColor?
	
	/// The border width of the picker backround view
	public var pickerBorderWidth: CGFloat = 1.0
	
	/// The corner radius of the picker background view
	public var pickerCornerRadius: CGFloat = 10.0
	
	/// The delegate of the date picker VC
	public var delegate: DatePickerDelegate?
	
	// MARK: - Init
	public init() {
		super.init(nibName: nil, bundle: nil)
		modalPresentationStyle = .overCurrentContext
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// MARK: - VC Lifecycle
	override public func viewDidLoad() {
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
	@objc fileprivate func cancelTapGesture(gestureRecogniser: UITapGestureRecognizer) {
		dismiss()
	}
	
	private func dismiss() {
		delegate?.datePickerWillDismissViewController?(self)
		dismiss(animated: true) {
			self.delegate?.datePickerDidDismissViewController?(self)
		}
	}
}
