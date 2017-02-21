//
//  CurrencyMenuCell.swift
//  Currency-Statist
//
//  Created by Nick Baidikoff on 2/19/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import UIKit

class CurrencyMenuCell: MenuCell {
	
	required init(frame: CGRect) {
		super.init(frame: frame)
		contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func updateData() {
		super.updateData()
		backgroundColor = .flatOrange
		titleLabel.textColor = selected ? .flatWhite : .flatWhiteDark
	}
}
