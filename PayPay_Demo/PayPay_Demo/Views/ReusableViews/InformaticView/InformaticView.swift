//
//  InformaticView.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/6/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit

@IBDesignable class InformaticView: UICustomView {
    
    //Outlets
    @IBOutlet weak var informaticsLabel: UILabel!
    
    //Inspectables
    @IBInspectable var informaticState: Int = 1 {
        didSet {
            if let changedState = InformaticState(rawValue: informaticState) {
                self.informaticStateEnum = changedState
            }
        }
    }

    public var informaticStateEnum: InformaticState = .generalError {
        didSet {
            if informaticsLabel != nil {
                self.informaticsLabel.text = self.informaticStateEnum.description
                self.informaticsLabel.backgroundColor = self.informaticStateEnum.backgroundColorSetting
            }
        }
    }
    
    //Default Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        try? loadAndSetupXib(nibName: "InformaticView").addSubview(contentView)
    }
}

