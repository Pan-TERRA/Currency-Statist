//
//  CustomDataViewController.swift
//  Currency Statist
//
//  Created by Nick Baidikoff on 3/28/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

@objc public protocol CustomDataPickerDelegate {
	
	/// Is called when user select new data
	///
	/// - parameter dataPicker: The DataPicker VC
	/// - parameter data: The new data
	///
	func dataPicker(_ dataPicker: CustomDataPickerViewController, didSelectData data: String?) -> Void

	/// Is called straight before the dismissing Date Picker VC
	///
	/// - parameter datePicker: The DatePicker VC
	///
	@objc optional func dataPickerWillDismissViewController(_ dataPicker: CustomDataPickerViewController) -> Void
	
	/// Is called straight after the dismissing Date Picker VC
	///
	/// - parameter datePicker: The Date Picker VC
	///
	@objc optional func dataPickerDidDismissViewController(_ dataPicker: CustomDataPickerViewController) -> Void
}

public class CustomDataPickerViewController: UIViewController {
	
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
	
	@IBOutlet weak var dataPicker: UIPickerView! {
		didSet {
			dataPicker.tintColor = dataPickerTintColor ?? mainColor
			dataPicker.backgroundColor = dataPickerBackgroundColor ?? mainColor
			dataPicker.reloadAllComponents()
		}
	}

	// MARK: - Properties
	public var data: [String] = [] {
		didSet {
			if dataPicker != nil {
				dataPicker.reloadAllComponents()
			}
		}
	}
	
	/// The title of the confirm button
	public var confirmButtonTitle: String = NSLocalizedString("Confirm", comment: "")
	
	/// The title of the cancel button
	public var cancelButtonTitle: String = NSLocalizedString("Cancel", comment: "")
	
	/// The main color of the view controller
	/// Replaces any other not specified colors
	public var mainColor: UIColor = .flatBlack
	
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
	public var dataPickerTextColor: UIColor?
	
	/// Tint color of the data picker
	public var dataPickerTintColor: UIColor? = .clear
	
	/// Background color of the data picker
	public var dataPickerBackgroundColor: UIColor? = .clear
	
	/// The border width of the picker backround view
	public var pickerBorderWidth: CGFloat = 1.0
	
	/// The corner radius of the picker background view
	public var pickerCornerRadius: CGFloat = 10.0
	
	/// The delegate of the date picker VC
	public var delegate: CustomDataPickerDelegate?
	
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
		
		dataPicker.reloadAllComponents()
	}
	
	// MARK: - Actions
	@IBAction func onConfirmTouchUpInside(_ sender: UIButton) {
		delegate?.dataPicker(self, didSelectData: data[dataPicker.selectedRow(inComponent: 0)])
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
		delegate?.dataPickerWillDismissViewController?(self)
		dismiss(animated: true) {
			self.delegate?.dataPickerDidDismissViewController?(self)
		}
	}
}

extension CustomDataPickerViewController: UIPickerViewDelegate {
	public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
		let attributes = [NSForegroundColorAttributeName: dataPickerTextColor ?? mainColor]
		return NSAttributedString(string: data[row], attributes: attributes)
	}
}

extension CustomDataPickerViewController: UIPickerViewDataSource {
	public func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return data.count
	}
}
