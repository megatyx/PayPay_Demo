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
        didSet {}
    }
    
    var currencyData: [Currency]? = nil {
        didSet {
            if currencyData != nil {
                DispatchQueue.main.async {
                    self.currencyCollectionView.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.currencyCollectionView.register(UINib(nibName: "CurrencyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CurrencyCollectionViewCell")
    }

}

extension CurrencyConversionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currencyData?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionViewCell", for: indexPath) as? CurrencyCollectionViewCell, let currency = self.currencyData?[indexPath.row] else {return generateGenericCell()}

        if cell.viewModel == nil {
            //cell.viewModel = currency
        }

        return cell
    }

    private func generateGenericCell() -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
