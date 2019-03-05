//
//  CurrencyCollectionViewCell.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/6/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var currencyAmountLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    var viewModel: CurrencyCollectionViewCellVM? {
        didSet {
            self.currencyNameLabel.text = viewModel?.currencyName ?? Constants.GenericErrorStrings.unknown
            self.currencyAmountLabel.text = viewModel != nil ? String(viewModel!.amount):Constants.GenericErrorStrings.unknown
        }
    }

}
