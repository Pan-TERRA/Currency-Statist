//
//  NSUserDefault+Dates.swift
//  Currency-Statist
//
//  Created by Vlad Krut on 21.02.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    private static let startDateKey = "startDate"
    private static let finishDateKey = "finishDate"
    
    open var startDate: Date {
        get {
            return value(forKey: UserDefaults.startDateKey) as? Date ?? Date()
        }
        set {
            set(newValue, forKey: UserDefaults.startDateKey)
        }
    }
    
    open var finishDate: Date {
        get {
            return value(forKey: UserDefaults.finishDateKey) as? Date ?? Date()
        }
        set {
            set(newValue, forKey: UserDefaults.finishDateKey)
        }
    }
}
