//
//  CurrencyTabBarController.swift
//  Currency-Statist
//
//  Created by Vlad Krut on 19.02.17.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit

class CurrencyTabBarController: UITabBarController {

    static let countOfCurrencies = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 0...CurrencyTabBarController.countOfCurrencies {
            let childViewController = CurrencyViewController(nibName: "CurrencyViewController", bundle: nil)
            addChildViewController(UINavigationController(rootViewController: childViewController))
        }
        
    }

}
