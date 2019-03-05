//
//  UICustomView.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/6/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit

enum UICustomViewError: String, Error {
    case loadFromXibFailed = "load from Xib failed"
}

class UICustomView: UIView {
    
    open var contentView: UIView!
    
    open func loadAndSetupXib(nibName: String) throws -> UICustomView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            throw UICustomViewError.loadFromXibFailed
        }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        contentView = view
        return self
    }
    open func rotate90Left() -> UICustomView {
        self.contentView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        return self
    }
}
