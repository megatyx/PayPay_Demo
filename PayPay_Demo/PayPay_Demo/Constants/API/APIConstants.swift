//
//  APIConstants.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/5/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

extension Constants {
    struct API {
        static let baseURL = "http://data.fixer.io/api/"
        struct Routes {
            static let latest = "latest"
        }

        struct Parameters {
            static let accessKey = "91c2c49f07767a130b3e7973feb957de"
            
            struct Keys {
                static let accessKey = "access_key"
                static let baseCurrency = "base"
                static let currencySymbols = "symbols"
            }
            
            
        }

        struct JSONPayloadKeys {

            struct ServerSpecific {
                static let success = "success"
                static let timeStamp = "timestamp"
                static let date = "date"
            }
        }
    }
}
