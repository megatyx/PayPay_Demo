//
//  APIHandler.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/6/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation
struct APIHandler {
    
    static func getLatest(base: String? = nil, symbols: [String]? = nil, completion: @escaping (CurrencyConversionVCViewModel?, APIError?) -> Void) {
        
        let urlFactory = URLFactory()
            .addString(Constants.API.Routes.latest)
            .addQuery(key: Constants.API.Parameters.Keys.accessKey,
                      value: Constants.API.Parameters.accessKey)
        
        if let base = base, Validators.currencySymbolIsValid(base: base) {
            urlFactory.addQuery(key: Constants.API.Parameters.Keys.baseCurrency,
                                value: base)
        }
        
        if let symbols = symbols, symbols.count > 0 {
            urlFactory.addQuery(key: Constants.API.Parameters.Keys.currencySymbols,
                                value: CurrencySymbolsQueryFactory.generateSymbolsQueryString(from: symbols))
        }
        
        let apiSession = APISession(url: try? urlFactory.make())
        
        apiSession.getData(completion: {data in
            let decoder = JSONDecoder()
            do {
                let viewModel = try decoder.decode(CurrencyConversionVCViewModel.self, from: data)
                completion(viewModel, nil)
            } catch {
                print(error.localizedDescription)
            }
        }, failure: {completion(nil, $0)})
    }
}
