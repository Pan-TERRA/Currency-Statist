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
	open var type: CurrencyType?
	open var currency: Currency? {
		didSet {
			setupDataForChart()
		}
	}
	
	open var currencyPriceChart: LineChartView? {
		didSet {
			currencyPriceChart?.setViewPortOffsets(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0)
			currencyPriceChart?.backgroundColor = .flatWhite
			currencyPriceChart?.gridBackgroundColor = .flatWhite
			currencyPriceChart?.chartDescription?.enabled = false
			currencyPriceChart?.dragEnabled = true
			currencyPriceChart?.setScaleEnabled(true)
			currencyPriceChart?.pinchZoomEnabled = true
			currencyPriceChart?.drawGridBackgroundEnabled = true
			
			let yAxis = currencyPriceChart?.leftAxis
			yAxis?.labelFont = UIFont(name: "HelveticaNeue-Light", size: 12.0) ?? .preferredFont(forTextStyle: .body)
			yAxis?.setLabelCount(6, force: false)
			yAxis?.labelTextColor = .flatBlack
			yAxis?.labelPosition = .insideChart
			yAxis?.drawGridLinesEnabled = true
			yAxis?.axisLineColor = .flatWhite
			
			let xAsis = currencyPriceChart?.xAxis
			xAsis?.labelFont = UIFont(name: "HelveticaNeue-Light", size: 12.0) ?? .preferredFont(forTextStyle: .body)
			xAsis?.setLabelCount(4, force: false)
			xAsis?.labelTextColor = .flatBlack
			xAsis?.labelPosition = .top
			xAsis?.drawGridLinesEnabled = true
			xAsis?.axisLineColor = .flatWhite
			
			currencyPriceChart?.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
		}
	}

	init(type: CurrencyType) {
		super.init(nibName: nil, bundle: nil)
		self.type = type
		self.title = type.description
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		var frame = view.bounds
		frame.origin = CGPoint(x: 0.0, y: 40.0)
		frame.size.height -= 40.0
		currencyPriceChart = LineChartView(frame: frame)
		
		if let currencyPriceChart = currencyPriceChart {
			view.addSubview(currencyPriceChart)
			setupDataForChart()
		}
	}
	
	func setupDataForChart() {
		if let currency = currency {
			var number = 0.0
			let sellValues = currency.salePriceSet.priceValues.map { entry -> ChartDataEntry in
				let entry = ChartDataEntry(x: number, y: entry.value)
				number += 1.0
				return entry
			}

			let sellDataSet = LineChartDataSet(values: sellValues, label: "Sale price")
			sellDataSet.colors = [.flatOrange]
			sellDataSet.circleColors = [.flatOrange]
			sellDataSet.circleHoleColor = .flatOrange
			sellDataSet.circleRadius = 4.0
			sellDataSet.fillColor = .flatOrange
			sellDataSet.mode = .cubicBezier
			sellDataSet.drawFilledEnabled = true
			
			currencyPriceChart?.clear()
			currencyPriceChart?.data = LineChartData(dataSet: sellDataSet)
		}
	}
}
