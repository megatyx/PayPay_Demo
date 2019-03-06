//
//  CurrencyRates.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/6/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation
struct CurrencyRates {
    let rates: [Currency]
}

extension CurrencyRates: Decodable {
    fileprivate enum CodingKeys: String, CodingKey {
        case rates = "rates"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let ratesDic = try container.decode([String:Float].self, forKey: .rates)
        var currencyArray = Array<Currency>()
        for currency in ratesDic {
            currencyArray.append(Currency(name: currency.key, amount: currency.value))
        }
        self.rates = currencyArray
    }
}
