//
//  SingleCurrencyViewController.swift
//  Currency-Statist
//
//  Created by Nick Baidikoff on 2/19/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit
import Charts

class SingleCurrencyViewController: UIViewController {
	open var currencyCode: String? {
		didSet {
			self.title = currencyCode
		}
	}
	
	open var currency: Currency? {
		didSet {
			setupDataForChart()
		}
	}
	
	open var currencyPriceChart: LineChartView? {
		didSet {
			currencyPriceChart?.setViewPortOffsets(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0)
			currencyPriceChart?.backgroundColor = .white
			currencyPriceChart?.tintColor = .white
			currencyPriceChart?.chartDescription?.enabled = false
			currencyPriceChart?.dragEnabled = true
			currencyPriceChart?.setScaleEnabled(true)
			currencyPriceChart?.pinchZoomEnabled = true
			currencyPriceChart?.drawGridBackgroundEnabled = true
			
			let yAxis = currencyPriceChart?.leftAxis
			yAxis?.labelFont = UIFont(name: "HelveticaNeue-Light", size: 12.0) ?? .preferredFont(forTextStyle: .body)
			yAxis?.setLabelCount(6, force: false)
			yAxis?.labelTextColor = .black
			yAxis?.labelPosition = .insideChart
			yAxis?.drawGridLinesEnabled = true
			yAxis?.axisLineColor = .white
			
			let xAsis = currencyPriceChart?.xAxis
			xAsis?.labelFont = UIFont(name: "HelveticaNeue-Light", size: 12.0) ?? .preferredFont(forTextStyle: .body)
			xAsis?.setLabelCount(4, force: false)
			xAsis?.labelTextColor = .black
			xAsis?.labelPosition = .top
			xAsis?.drawGridLinesEnabled = true
			xAsis?.axisLineColor = .white
			
			currencyPriceChart?.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		var frame = view.bounds
		frame.origin = CGPoint(x: 0.0, y: 120.0)
		frame.size.height -= 120.0
		currencyPriceChart = LineChartView(frame: frame)
		
		if let currencyPriceChart = currencyPriceChart {
			view.addSubview(currencyPriceChart)
			setupDataForChart()
		}
	}
	
	func setupDataForChart() {
		if let currency = currency {
			let sellValues = currency.salePriceSet.priceValues.map { return ChartDataEntry(x: $0.date.timeIntervalSince1970, y:$0.value)}
			let sellDataSet = LineChartDataSet(values: sellValues, label: "Sale price")
			sellDataSet.colors = [.orange]
			sellDataSet.circleColors = [.orange]
			sellDataSet.circleHoleColor = .orange
			sellDataSet.circleRadius = 4.0
			sellDataSet.mode = .cubicBezier
			sellDataSet.drawFilledEnabled = true
			
			currencyPriceChart?.data = LineChartData(dataSet: sellDataSet)
		}
	}
}
