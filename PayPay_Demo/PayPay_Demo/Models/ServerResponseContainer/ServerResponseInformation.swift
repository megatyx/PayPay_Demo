//
//  ServerResponseInformation.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/7/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct ServerResponseInformation {
    let isSuccess: Bool?
    let timeStamp: Date?
}

extension ServerResponseInformation: Decodable {
    fileprivate enum CodingKeys: String, CodingKey {
        case isSuccess = "success"
        case timeStamp = "timestamp"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isSuccess = try? container.decode(Bool.self, forKey: .isSuccess)
        if let timeStampInterval = try? container.decode(TimeInterval.self, forKey: .timeStamp) {
            self.timeStamp = Date(timeIntervalSince1970: timeStampInterval)
        } else {
            self.timeStamp = nil
        }
    }
}
