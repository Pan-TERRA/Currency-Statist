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

class RateValueFormatter: NSObject, IAxisValueFormatter {
	func stringForValue(_ value: Double, axis: AxisBase?) -> String {
		return "\(value)"
	}
}

class RateDataSetValueFormatter: NSObject, IValueFormatter {
	func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
		return String(format: "%.3f", value)
	}
}
