//
//  APIError.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/6/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

enum APIError: Error, CustomStringConvertible {
    
    //Generics
    case unknown
    case urlCasting
    
    //Data Specific
    case payloadParse
    case dictionaryParse
    case dataParseInvalidTimeStamp
    
    //Response Specific
    case unknown200
    case unknown300
    case unknown400
    case unknown500
    case internalServerError
    case notFound
    case noResponse
    case forbidden
    
    //Device Specific
    case unreachableInternetDisabled
    
    var description: String {
        switch self {
        case .unknown, .unknown200, .unknown300, .unknown400, .unknown500:
            return "Unknown Error".localize()
        case .payloadParse:
            return "JSON payload from the server couldn't be parsed into specified data stucture".localize()
        case .dictionaryParse:
            return "JSON payload could not conform to Dicionary -> [String:Any]".localize()
        case .internalServerError:
            return "Internal Server Error".localize()
        case .notFound:
            return "Not Found".localize()
        case .noResponse:
            return "Server Unreachable".localize()
        case .forbidden:
            return "Forbidden".localize()
        case .urlCasting:
            return "Unable to cast URL correctly".localize()
        case .unreachableInternetDisabled:
            return "Network call unreachable due to device internet settings being disabled".localize()
        case .dataParseInvalidTimeStamp:
            return "Timestamp is missing or improperly parsed".localize()
        }
    }
}
