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
    @IBInspectable var displayText: String = "" {
        didSet {
            self.informaticsLabel.text = displayText
        }
    }
    
    @IBInspectable var textColor: UIColor = UIColor.white {
        didSet {
            self.informaticsLabel.textColor = textColor
        }
    }
    
    @IBInspectable var defaultBackgroundColor: UIColor = UIColor.green {
        didSet {
            self.backgroundColor = defaultBackgroundColor
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

