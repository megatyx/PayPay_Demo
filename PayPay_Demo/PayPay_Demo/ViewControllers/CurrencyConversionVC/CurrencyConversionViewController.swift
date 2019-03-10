//
//  CurrencyConversionViewController.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/5/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit
class CurrencyConversionViewController: UIViewController {

    @IBOutlet weak var currencyCollectionView: UICollectionView!

    var viewModel: CurrencyConversionVCViewModel? = nil {
        didSet {
            if viewModel != nil {
                self.currencyCollectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.currencyCollectionView.register(UINib(nibName: "CurrencyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CurrencyCollectionViewCell")
        
        APIHandler.getLatest(success: {newViewModel in
            self.viewModel = newViewModel
        }, failure: {print($0?.description ?? $0?.localizedDescription ?? "")})
    }

}

extension CurrencyConversionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width / 2) < 150 ? (collectionView.frame.width / 2):150
        return CGSize(width: width, height: width)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.currencyRates.rates.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionViewCell", for: indexPath) as? CurrencyCollectionViewCell, let currency = self.viewModel?.currencyRates.rates[indexPath.row] else {return generateGenericCell()}

        if cell.viewModel == nil {
            cell.viewModel = CurrencyCollectionViewCellVM(currency: currency)
        }

        return cell
    }

    private func generateGenericCell() -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
