//
//  GetLatestAPI.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/9/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

extension APIHandler {
    static func getLatest(base: String? = nil, symbols: [String]? = nil, success: @escaping (CurrencyConversionVCViewModel) -> Void, failure: @escaping (APIError?) -> Void) {
        
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
        
        do {
            let url = try urlFactory.make()
            let apiSession = APISession(url: url)
            apiSession.getData(completion: {data in
                let decoder = JSONDecoder()
                do {
                    let serverData = try decoder.decode(ServerResponseInformation.self, from: data)
                    if serverData.isSuccess {
                        let viewModel = try decoder.decode(CurrencyConversionVCViewModel.self, from: data)
                        success(viewModel)
                    } else {
                        print(APIError.unsuccessfulPayload.description)
                        failure(APIError.unsuccessfulPayload)
                    }
                } catch {
                    print(error.localizedDescription)
                    failure(error as? APIError)
                }
            }, failure: {failure($0)})
        } catch {
            print(error.localizedDescription)
            failure(APIError.urlCasting)
        }
    }
}
