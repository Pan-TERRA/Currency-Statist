//
//  Swift+CurrencyStatist.swift
//  Currency Statist
//
//  Created by Nick Baidikoff on 3/22/17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation

func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
	var i = 0
	return AnyIterator {
		let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
		if next.hashValue != i { return nil }
		i += 1
		return next
	}
}
