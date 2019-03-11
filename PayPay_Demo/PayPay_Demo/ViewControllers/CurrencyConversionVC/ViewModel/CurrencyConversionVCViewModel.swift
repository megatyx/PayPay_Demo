//
//  CurrencyConversionVCViewModel.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/7/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

struct CurrencyConversionVCViewModel {
    var userInputAmount: Float
    let baseDenomination: String
    let currencyRates: CurrencyRates
    
    var filteredRates: CurrencyRates
    
    init(userInputAmount: Float? = nil, baseDenomination: String? = nil, currencyRates: CurrencyRates = CurrencyRates(rates: [Currency]()), fiteredRates: CurrencyRates = CurrencyRates(rates: [Currency]())) {
        self.userInputAmount = userInputAmount ?? 1
        self.baseDenomination = baseDenomination ?? "JPY"
        self.currencyRates = CurrencyRates(rates: currencyRates.rates.sorted(by:{$0.name < $1.name}))
        self.filteredRates = self.currencyRates
    }
    
    mutating func filterCurrencyRatesFor(filterList: [String]) {
        self.filteredRates = CurrencyRates(rates: self.currencyRates.rates.filter({filterList.contains($0.name)}))
    }
}

extension CurrencyConversionVCViewModel {
    func getLatest(completion: @escaping (CurrencyConversionVCViewModel, String?) -> Void) {
        APIHandler.getLatest(success: {base, rates in
            completion(CurrencyConversionVCViewModel(baseDenomination: base, currencyRates: rates), nil)
        }, failure: {completion(CurrencyConversionVCViewModel(), ($0 as? APIError)?.description ?? $0?.localizedDescription)})
    }
    
}

