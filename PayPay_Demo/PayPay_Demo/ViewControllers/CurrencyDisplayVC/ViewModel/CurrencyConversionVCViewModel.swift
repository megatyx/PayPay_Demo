//
//  CurrencyConversionVCViewModel.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/7/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

struct CurrencyDisplayVCViewModel {
    var userInputAmount: Float
    let baseDenomination: String
    let currencyRates: CurrencyRates
    
    var filteredRates: [Currency]
    
    init(userInputAmount: Float? = nil, baseDenomination: String? = nil, currencyRates: CurrencyRates = CurrencyRates(rates: [Currency]()), fiteredRates: CurrencyRates = CurrencyRates(rates: [Currency]())) {
        self.userInputAmount = userInputAmount ?? 1
        self.baseDenomination = baseDenomination ?? "JPY"
        self.currencyRates = CurrencyRates(rates: currencyRates.rates.sorted(by:{$0.name < $1.name}))
        self.filteredRates = self.currencyRates.rates
    }
    
    mutating func filterCurrencyRatesFor(filterList: [String]) {
        self.filteredRates = self.currencyRates.rates.filter({filterList.contains($0.name)})
    }
    
    /*
        You might ask yourself, "why is he returning a ViewModel to overwrite the current one?"
        The answer is that I want to preserve the "by value" nature of the struct here to completely eleminate the possibility
        of memory leaks that can occur from strong retain cycles on the view model. Because the ViewModel is so small and
        simple, it is faster and more safe to just replace the ViewModel struct rather than, what would normally be the case,
        using a class. If the struct was much larger with more varied types, it might be better to use a class.
     */
    func getLatest(completion: @escaping (CurrencyDisplayVCViewModel, String?) -> Void) {
        APIHandler.getLatest(success: {base, rates in
            completion(CurrencyDisplayVCViewModel(baseDenomination: base, currencyRates: rates), nil)
        }, failure: {completion(CurrencyDisplayVCViewModel(), ($0)?.description ?? $0?.localizedDescription)})
    }
}
