//
//  CurrencyDisplayViewController.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/5/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit
class CurrencyDisplayViewController: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var currencyCollectionView: UICollectionView!
    @IBOutlet weak var informaticView: InformaticView!
    @IBOutlet weak var informaticViewHeight: NSLayoutConstraint!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var baseCurrencyLabel: UILabel!

    // MARK: - Button Outlets and Actions
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBAction func refreshButtonAction(_ sender: UIBarButtonItem) {
        self.refreshData()
    }
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBAction func filterButtonAction(_ sender: UIBarButtonItem) {
        self.moveToFilterView()
    }
    
    // MARK:- View Variables
    var shouldHideInformaticView: Bool = true {
        didSet {
            if informaticViewHeight != nil && informaticView != nil {
                UIView.animate(withDuration: 0.25, animations: { [weak self] in
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
                self.refreshButton.isEnabled = false
                self.shouldHideInformaticView = false
                self.informaticView.informaticStateEnum = .refreshing
            } else {
                self.shouldHideInformaticView = true
                self.refreshButton.isEnabled = true
            }
        }
    }
    
    // MARK:- ViewModel
    /*
        Please note that because the initial ViewController is this particular VC, I have to break
        the MVVM convention for the sake of simplicity and time. Normally, you would not have a viewModel
        initiated like this in this way.
     */
    var viewModel: CurrencyDisplayVCViewModel! = CurrencyDisplayVCViewModel()

    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currencyCollectionView.register(UINib(nibName: "CurrencyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CurrencyCollectionViewCell")
        self.refreshData()
    }
    
    // MARK:- Rotation Methods
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if !self.shouldHideInformaticView {
            self.informaticViewHeight.constant = self.calculateNeededInfoViewHeight()
        }
    }
    
    // MARK:- ControllerMethods
    private func calculateNeededInfoViewHeight() -> CGFloat {
        var height: CGFloat = CGFloat(self.view.frame.height / 10)
        let maximumHeight: CGFloat = 150
        let minimumHeight: CGFloat = 45
        height = (height > maximumHeight) ? maximumHeight:height
        height = (height < minimumHeight) ? minimumHeight:height
        return height
    }
    
    private func refreshData() {
        guard let viewModel = viewModel else {return}
        self.isRefreshing = true
        viewModel.getLatest(completion: { [weak self] newViewModel, errorString in
            self?.isRefreshing = false
            if errorString != nil {print(errorString ?? ""); return}
            self?.viewModel = newViewModel
            self?.updateViewDataUI()
        })
    }
    
    private func updateViewDataUI() {
        guard let viewModel = self.viewModel else {return}
        self.baseCurrencyLabel.text = viewModel.baseDenomination
        self.numberLabel.text = String(viewModel.userInputAmount)
        self.currencyCollectionView.reloadData()
    }
    
    private func moveToFilterView() {
        guard let storyboard = self.storyboard,
            let controller = storyboard.instantiateViewController(withIdentifier: "FilterSelecterTableViewController") as? FilterSelecterTableViewController,
            let selectionList = self.viewModel?.currencyRates.rates.map({return $0.name}) else {return}
        controller.viewModel = FilterSelectorViewModel(selectionList: selectionList, delegate: self)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showConversionView() {
        
    }
}

// MARK: - ColletionView Delegate
extension CurrencyDisplayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width / 2) < 100 ? (collectionView.frame.width / 2):100
        return CGSize(width: width, height: width)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.filteredRates.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionViewCell", for: indexPath) as? CurrencyCollectionViewCell else {return UICollectionViewCell()}
            cell.viewModel = CurrencyCollectionViewCellVM(currency: self.viewModel.filteredRates[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let possibleActions = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        possibleActions.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        possibleActions.addAction(UIAlertAction(title: "Convert Menu", style: .default, handler: { action in
            return
        }))
        
        possibleActions.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { action in
            collectionView.performUsingPresentationValues {
                self.viewModel.filteredRates.remove(at: indexPath.row)
                collectionView.deleteItems(at: [indexPath])
            }
        }))
        
        if UIDevice.current.userInterfaceIdiom == .pad  {
            possibleActions.popoverPresentationController?.sourceView = collectionView.cellForItem(at: indexPath)
        }
        self.present(possibleActions, animated: true)
    }
}

// MARK: - Filter Selection Delegate
extension CurrencyDisplayViewController: FilterSelectorDelegate {
    func didSelect(currencyNames: [String]) {
        self.viewModel?.filterCurrencyRatesFor(filterList: currencyNames)
        self.currencyCollectionView.reloadData()
    }
}
