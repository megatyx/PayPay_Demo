//
//  LatestRates.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/7/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct LatestRates {
    var rates: CurrencyRates
    var base: Currency
    var rateDate: Date
}

extension LatestRates: Decodable {
    fileprivate enum CodingKeys: String, CodingKey {
        case base
        case rateDate = "date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rates = try CurrencyRates(from: decoder)
        let baseString = try container.decode(String.self, forKey: .base)
        self.base = Currency.init(name: baseString, amount: 1)
        self.rateDate = Date()
    }
}
