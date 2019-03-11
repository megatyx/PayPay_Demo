//
//  CurrencyConversionViewModel.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/12/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct CurrencyConversionViewModel {
    var fromCurrency: Currency
    var toCurrency: Currency
    
    func convert(completion: @escaping (Currency?) -> Void) {
        APIHandler.convertCurrency(from: fromCurrency.name, to: toCurrency.name, amount: fromCurrency.amount, success: {completion($1)}, failure: {print($0?.description ?? "")})
    }
}
