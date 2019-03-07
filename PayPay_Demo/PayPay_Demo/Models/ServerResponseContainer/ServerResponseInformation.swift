//
//  ServerResponseInformation.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/7/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation

struct ServerResponseInformation {
    let success: Bool
    let timeStamp: Date
}

extension ServerResponseInformation: Decodable {
    fileprivate enum CodingKeys: String, CodingKey {
        case success
        case timeStamp = "timestamp"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
        guard let timeStampInterval = try? container.decode(TimeInterval.self, forKey: .timeStamp) else {throw APIError.dataParseInvalidTimeStamp}
            self.timeStamp = Date(timeIntervalSince1970: timeStampInterval)
    }
}
