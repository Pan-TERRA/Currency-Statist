//
//  DateValueFormatter.swift
//  Currency-Statist
//
//  Created by Vlad Krut on 22.02.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import Charts

class DateValueFormatter: NSObject {
    
    open let dateFormatter = DateFormatter()
    
    init(withDateFormat format: String) {
        dateFormatter.dateFormat = format
    }
}

extension DateValueFormatter: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
