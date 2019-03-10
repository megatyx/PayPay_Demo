//
//  CurrencyConversionVCViewModel.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/7/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

struct CurrencyConversionVCViewModel {
    var userInputAmount: Float
    var baseDenomination: String
    var currencyRates: CurrencyRates
    
    init(userInputAmount: Float? = nil, baseDenomination: String? = nil, currencyRates: CurrencyRates? = nil){
        self.userInputAmount = userInputAmount ?? 1
        self.baseDenomination = baseDenomination ?? "JPY"
        self.currencyRates = currencyRates ?? CurrencyRates(rates: [Currency]())
    }
}

