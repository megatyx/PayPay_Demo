//
//  StringExtensions.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/6/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

extension String {
    func localize(tableName: String? = nil, bundle:Bundle = Bundle.main, value: String = "", comment: String = "")->String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: comment)
    }
}
