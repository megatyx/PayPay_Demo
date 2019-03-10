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
        viewModel.getLatest(success: {self.viewModel = $0}, failure: {print($0)})
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
