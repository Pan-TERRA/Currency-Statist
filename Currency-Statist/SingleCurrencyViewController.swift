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
			currencyPriceChart?.backgroundColor = .white
			currencyPriceChart?.drawGridBackgroundEnabled = true
			currencyPriceChart?.drawBordersEnabled = true
			currencyPriceChart?.pinchZoomEnabled = true
			currencyPriceChart?.dragEnabled = true
			currencyPriceChart?.legend.enabled = true
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		var frame = view.bounds
		frame.origin = CGPoint(x: 16.0, y: 120.0)
		frame.size.width -= 32.0
		frame.size.height -= 120.0
		currencyPriceChart = LineChartView(frame: frame)
		
		if let currencyPriceChart = currencyPriceChart {
			view.addSubview(currencyPriceChart)
			setupDataForChart()
		}
	}
	
	func setupDataForChart() {
		if let currency = currency {
			let purchaseValues = currency.purchasePriceSet.priceValues.map { return ChartDataEntry(x: $0.date.timeIntervalSince1970, y: $0.value)}
			let purchaseDataSet = LineChartDataSet(values: purchaseValues, label: "Purchase price")
			purchaseDataSet.colors = [.orange]
			
			let sellValues = currency.salePriceSet.priceValues.map { return ChartDataEntry(x: $0.date.timeIntervalSince1970, y:$0.value)}
			let sellDataSet = LineChartDataSet(values: sellValues, label: "Sell price")
			sellDataSet.colors = [.green]
			
			currencyPriceChart?.data = LineChartData(dataSets: [purchaseDataSet, sellDataSet])
		}
	}
}
