//
//  URLFactory.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/6/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

class URLFactory {
    
    private var urlString = ""
    
    init(baseURL: String = Constants.API.baseURL) {
        urlString = baseURL
    }
    
    public class func cleanseURL(urlString: String? = nil, uncleanURL: URL? = nil, encodedOnceBefore: Bool = false) -> URL? {
        guard let initialString = urlString ?? uncleanURL?.absoluteString else {return nil}
        let characterSet = generateURLCharacterSet(encodedOnceBefore)
        guard let encodedURLString = initialString.addingPercentEncoding(withAllowedCharacters: characterSet) else {return nil}
        return URL(string: encodedURLString)
    }
    
    public class func generateURLCharacterSet(_ encodedOnceBefore: Bool = false) -> CharacterSet {
        return (encodedOnceBefore) ? CharacterSet.alphanumerics
            .union(.urlHostAllowed)
            .union(.urlQueryAllowed)
            .subtracting(CharacterSet(charactersIn: "%&"))
            :CharacterSet.alphanumerics
                .union(.urlHostAllowed)
                .union(.urlQueryAllowed)
    }
    
    func make() throws -> URL {
        guard let url = URL(string: urlString) else {throw APIError.urlCasting}
        return url
    }
    
    @discardableResult
    func addQuery(key: String, value: String) -> URLFactory {
        if let keyString =  (key + "=").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let valueString = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if !urlString.contains("?") {
                self.urlString += "?"
            }
            if urlString.last != "?" {
                self.urlString += "&"
            }
            self.urlString += keyString + valueString
        }
        return self
    }
    
    @discardableResult
    func addString(_ someString: String, isPiped: Bool = true) -> URLFactory {
        self.urlString += (isPiped ? "\(someString)/":"\(someString)")
        return self
    }
    
    func getUrlString() -> String {
        return urlString
    }
}
