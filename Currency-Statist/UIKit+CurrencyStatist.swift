//
//  UIKit+CurrencyStatist.swift
//  Currency-Statist
//
//  Created by Nick Baidikoff on 2/22/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

extension UIAlertController {
	public convenience init(error: Error) {
		self.init(title: NSLocalizedString("Error", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
		addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
	}
}

protocol ErrorHandler: class {
	func handle(_ error: Error)
}

extension ErrorHandler where Self: NSObject {
	func handle(_ error: Error) {
		print(error.localizedDescription)
	}
}

extension ErrorHandler where Self: UIViewController {
	func handle(_ error: Error) {
		let alert = UIAlertController(error: error)
		present(alert, animated: true, completion: nil)
	}
}
