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
    var currencyData: CurrencyRates
    
    init(userInputAmount: Float? = nil, baseDenomination: String? = nil, currencyData: CurrencyRates? = nil){
        self.userInputAmount = userInputAmount ?? 1
        self.baseDenomination = baseDenomination ?? "JPY"
        self.currencyData = currencyData ?? CurrencyRates(rates: [Currency]())
    }
}

extension CurrencyConversionVCViewModel: Decodable {
    
    fileprivate enum CodingKeys: String, CodingKey {
        case base = "base"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rates = try? CurrencyRates(from: decoder)
        let base = try? container.decode(String.self, forKey: .base)
        self.init(baseDenomination: base, currencyData: rates)
    }
}

