//
//  CurrencyConversionViewController.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/12/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit

class CurrencyConversionViewController: UIViewController {

    // Mark: - ViewModel
    var viewModel: CurrencyConversionViewModel!
    
    // Mark: - Outlets
    @IBOutlet weak var conversionContainerView: UIView! {
        didSet {
            conversionContainerView.layer.borderWidth = 1
            conversionContainerView.layer.borderColor = UIColor.black.cgColor
            conversionContainerView.layer.cornerRadius = 8.0
        }
    }
    @IBOutlet weak var conversionContainerViewWidth: NSLayoutConstraint!
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var fromCurrencyDenominationButton: UIButton! {
        didSet {
            fromCurrencyDenominationButton.layer.borderWidth = 1
            fromCurrencyDenominationButton.layer.borderColor = UIColor.black.cgColor
            fromCurrencyDenominationButton.layer.cornerRadius = 8.0
        }
    }
    @IBAction func fromCurrencyDenominationButtonAction(_ sender: UIButton) {
        
    }
    
    
    @IBOutlet weak var toCurrencyAmountLabel: UILabel!
    @IBOutlet weak var toCurrencyDenominationButton: UIButton! {
        didSet {
            toCurrencyDenominationButton.layer.borderWidth = 1
            toCurrencyDenominationButton.layer.borderColor = UIColor.black.cgColor
            toCurrencyDenominationButton.layer.cornerRadius = 8.0
        }
    }
    @IBAction func toCurrencyDenominationButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func switchButtonAction(_ sender: UIButton) {
        let swapVar = viewModel.fromCurrency
        self.viewModel.fromCurrency = viewModel.toCurrency
        self.viewModel.toCurrency = swapVar
        self.updateUI()
    }
    
    @IBAction func convertButtonAction(_ sender: UIButton) {
        if let userAmountString = fromCurrencyTextField.text,
            let userAmount = Float(userAmountString) {
            viewModel.fromCurrency.amount = userAmount
            viewModel.convert(completion: { [weak self] currency in
                guard let currency = currency else {return}
                self?.viewModel.toCurrency = currency
                self?.updateUI()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = self.view.backgroundColor?.withAlphaComponent(0.4)
        self.setContentSize()
        self.updateUI()
    }
    
    // MARK:- Rotation Methods
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.setContentSize()
    }
    
    private func updateUI() {
        self.fromCurrencyTextField.text = String(viewModel.fromCurrency.amount)
        self.fromCurrencyDenominationButton.setTitle(viewModel.fromCurrency.name, for: .normal)
        self.toCurrencyDenominationButton.setTitle(viewModel.toCurrency.name, for: .normal)
        self.toCurrencyAmountLabel.text = String(self.viewModel.toCurrency.amount)
    }
    
    private func setContentSize() {
        let width = self.view.frame.width * 0.65
        let height = self.view.frame.height * 0.65
        if width < height {
            self.conversionContainerViewWidth.constant = width
        } else {
            self.conversionContainerViewWidth.constant = height
        }
    }
}
