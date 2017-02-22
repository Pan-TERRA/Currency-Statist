//
//  UserDefaults+CurencyStatist.swift
//  Currency-Statist
//
//  Created by Nick Baidikoff on 2/22/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
	open static let minimumDate = DefaultsKey<Date?>("minimumDate")
	open static let maximumDate = DefaultsKey<Date?>("maximumDate")
	
	open static let startDate = DefaultsKey<Date?>("startDate")
	open static let finishDate = DefaultsKey<Date?>("finishDate")
}
