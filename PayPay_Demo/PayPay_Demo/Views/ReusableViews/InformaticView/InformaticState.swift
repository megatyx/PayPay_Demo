//
//  InformaticState.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/11/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import Foundation
import UIKit

enum InformaticState: Int {
    case generalError = 0, connected, notConnected, refreshing, unknown

    var description: String {
        switch self {
        case .generalError:
            return "something went wrong"
        case .refreshing:
            return "refreshing..."
        case .notConnected:
            return "Disconnected"
        case .connected:
            return "Connected"
        case .unknown:
            return Constants.GenericErrorStrings.unknown
        }
    }

    var backgroundColorSetting: UIColor {
        switch self {
        case .refreshing:
            return UIColor.blue
        case .notConnected:
            return UIColor.red
        case .connected:
            return UIColor.green
        default:
            return UIColor.red
        }
    }
}
