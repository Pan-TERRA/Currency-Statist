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
	
	override func viewDidLoad() {
		var frame = view.bounds
		frame.origin = CGPoint(x: 16.0, y: 120.0)
		frame.size.width -= 32.0
		frame.size.height -= 120.0
		let currencyPriceChart = LineChartView(frame: frame)
		
		currencyPriceChart.backgroundColor = .white
		currencyPriceChart.drawGridBackgroundEnabled = true
		currencyPriceChart.drawBordersEnabled = true
		currencyPriceChart.pinchZoomEnabled = true
		currencyPriceChart.dragEnabled = true
		currencyPriceChart.legend.enabled = true
		
		let buyDataSet = LineChartDataSet(values: [ChartDataEntry(x: 1.0, y: 5.0), ChartDataEntry(x: 2.0, y: 6.0), ChartDataEntry(x: 3.0, y: 11.0), ChartDataEntry(x: 4.0, y: 0.0), ChartDataEntry(x: 5.0, y: 5.0), ChartDataEntry(x: 6.0, y: 25.0), ChartDataEntry(x: 7.0, y: 10.0)], label: "Buy price")
		buyDataSet.colors = [.green]
		
		let cellDataSet = LineChartDataSet(values: [ChartDataEntry(x: 1.0, y: 8.0), ChartDataEntry(x: 2.0, y: 2.0), ChartDataEntry(x: 3.0, y: 15.0), ChartDataEntry(x: 4.0, y: 10.0), ChartDataEntry(x: 5.0, y: 3.0), ChartDataEntry(x: 6.0, y: 13.0), ChartDataEntry(x: 7.0, y: 2.0)], label: "Sell price")
		cellDataSet.colors = [.orange]
		
		currencyPriceChart.data = LineChartData(dataSets: [buyDataSet, cellDataSet])
		
		view.addSubview(currencyPriceChart)
	}
}
