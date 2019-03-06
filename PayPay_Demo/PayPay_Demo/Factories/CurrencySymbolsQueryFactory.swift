//
//  CurrencySymbolsQueryFactory.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/7/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//


struct CurrencySymbolsQueryFactory {
    static func generateSymbolsQueryString(from symbols: [String]) -> String {
        var generatedString = ""
        for symbol in symbols {
            generatedString += symbol
            if symbol != symbols.last {
                generatedString += ","
            }
        }
        return generatedString
    }
}
