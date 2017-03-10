//
//  DateValueFormatter.swift
//  Currency-Statist
//
//  Created by Vlad Krut on 22.02.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import Charts

class DateValueFormatter: NSObject, IAxisValueFormatter {
	func stringForValue(_ value: Double, axis: AxisBase?) -> String {
		return DateFormatter.shortLocalized.string(from: Date(timeIntervalSince1970: value))
	}
}
