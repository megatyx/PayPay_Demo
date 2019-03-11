//
//  CurrencyConversionViewController.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/5/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit
class CurrencyConversionViewController: UIViewController {

    //MARK :- Outlets
    @IBOutlet weak var currencyCollectionView: UICollectionView!
    @IBOutlet weak var informaticView: InformaticView!
    @IBOutlet weak var informaticViewHeight: NSLayoutConstraint!

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshButtonHeight: NSLayoutConstraint!
    @IBAction func refreshButtonAction(_ sender: UIButton) {
        guard let viewModel = viewModel else {return}
        self.informaticView.informaticStateEnum = .refreshing
        self.shouldHideInformaticView = false
        viewModel.getLatest(completion: { [weak self] newViewModel, errorString in
            self?.shouldHideInformaticView = true
            if errorString != nil {print(errorString ?? ""); return}
            self?.viewModel = newViewModel
        })
    }

    //MARK :- View Variables
    var shouldHideInformaticView: Bool = true {
        didSet {
            if informaticViewHeight != nil && informaticView != nil {
                UIView.animate(withDuration: 0.05, animations: { [weak self] in
                    guard let self = self else {return}
                    if self.shouldHideInformaticView {
                        self.informaticViewHeight.constant = 0
                    } else {
                        self.informaticViewHeight.constant = self.calculateNeededInfoViewHeight()
                    }
                })
            }
        }
    }

    var isRefreshing: Bool = false {
        didSet {
            if isRefreshing {
                self.shouldHideInformaticView = true
                self.informaticView.informaticStateEnum = .refreshing
            } else {
                self.shouldHideInformaticView = false
            }
        }
    }
    
    //ViewModel
    var viewModel: CurrencyConversionVCViewModel? = CurrencyConversionVCViewModel() {
        didSet {
            if viewModel != nil {
                self.currencyCollectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.currencyCollectionView.register(UINib(nibName: "CurrencyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CurrencyCollectionViewCell")
        guard let viewModel = viewModel else {return}
        self.isRefreshing = true
        viewModel.getLatest(completion: { [weak self] newViewModel, errorString in
            self?.isRefreshing = false
            if errorString != nil {print(errorString ?? ""); return}
            self?.viewModel = newViewModel
        })
    }

    private func calculateNeededInfoViewHeight() -> CGFloat {
        var height: CGFloat = CGFloat(self.view.frame.height / 10)
        let maximumHeight: CGFloat = 150
        let minimumHeight: CGFloat = 45
        height = (height > maximumHeight) ? maximumHeight:height
        height = (height < minimumHeight) ? minimumHeight:height
        return height
    }

}

extension CurrencyConversionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width / 2) < 100 ? (collectionView.frame.width / 2):100
        return CGSize(width: width, height: width)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.filteredRates.rates.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionViewCell", for: indexPath) as? CurrencyCollectionViewCell, let currency = self.viewModel?.filteredRates.rates[indexPath.row] else {return UICollectionViewCell()}

        if cell.viewModel == nil {
            cell.viewModel = CurrencyCollectionViewCellVM(currency: currency)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let possibleActions = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        possibleActions.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        possibleActions.addAction(UIAlertAction(title: "Convert Menu", style: .default, handler: { action in
            return
        }))
        
        if UIDevice.current.userInterfaceIdiom == .pad  {
            possibleActions.popoverPresentationController?.sourceView = collectionView.cellForItem(at: indexPath)
        }
        self.present(possibleActions, animated: true)
    }
}
