//
//  ConvertCurrencyAPI.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/9/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

extension APIHandler {
    static func convertCurrency(from fromCurrency: String, to toCurrency: String, amount: Float, onHistoricalDate: String? = nil, success: @escaping () -> Void, failure: @escaping (APIError?) -> Void) {
        
        if Validators.currencySymbolIsValid(base: fromCurrency) && Validators.currencySymbolIsValid(base: toCurrency) {
            failure(APIError.invalidParameters)
            return
        }
        
        let urlFactory = URLFactory()
            .addString(Constants.API.Routes.convert)
            .addQuery(key: Constants.API.Parameters.Keys.accessKey, value: Constants.API.Parameters.accessKey)
            .addQuery(key: Constants.API.Parameters.Keys.fromCurrency, value: fromCurrency)
            .addQuery(key: Constants.API.Parameters.Keys.toCurrency, value: toCurrency)
            .addQuery(key: Constants.API.Parameters.Keys.amount, value: String(amount))
        
        if let onHistoricalDate = onHistoricalDate, Validators.dateStringIsvalid(dateString: onHistoricalDate) {
            urlFactory.addQuery(key: Constants.API.Parameters.Keys.date, value: onHistoricalDate)
        } else if onHistoricalDate != nil {
            print("PROGRAMMER_ERROR: Invalid Historical date passed to function. Please check the format of the String")
            failure(APIError.invalidParameters)
        }
        
        do {
            let url = try urlFactory.make()
            let apiSession = APISession(url: url)
            apiSession.getData(completion: {data in
                let decoder = JSONDecoder()
                do {
                    let serverData = try decoder.decode(ServerResponseInformation.self, from: data)
                    if let isSuccess = serverData.isSuccess, isSuccess {
                        guard let jsonDic = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                            let queryDic =  jsonDic?["query"] as? [String:Any],
                            let fromSymbol = queryDic["from"] as? String,
                            let toSymbol = queryDic["to"] as? String,
                            let _ = jsonDic?["info"] as? [String:Any],
                            let result = jsonDic?["result"] as? Float else {failure(APIError.dictionaryParse);return}
                        let fromCurr = Currency(name: fromSymbol, amount: amount)
                        let toCurr = Currency(name: toSymbol, amount: result)
                        success()
                    } else {
                        print(APIError.unsuccessfulPayload.description)
                        failure(APIError.unsuccessfulPayload)
                    }
                } catch {
                    print(error.localizedDescription)
                    failure(error as? APIError)
                }
            }, failure: {failure($0)})
        } catch let error as APIError {
            print(error.description)
            failure(error)
        } catch {
            print(error.localizedDescription)
            failure(nil)
        }
    }
}
