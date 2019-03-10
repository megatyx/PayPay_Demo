//
//  Validators.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/7/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct Validators {
    
    static func currencySymbolIsValid(base: String) -> Bool {
        if (!base.isEmpty && base.count == 3) {
            return true
        }
        return false
    }
    
    static func dateStringIsvalid(dateString: String) -> Bool {
        if (!dateString.isEmpty && dateString.count == 10) {
            return true
        }
        return false
    }
}
