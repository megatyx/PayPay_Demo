//
//  FilterSelecterTableViewController.swift
//  PayPay_Demo
//
//  Created by Tyler Wells on 3/12/19.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit

class FilterSelecterTableViewController: UITableViewController {

    // MARK: - ViewModel
    var viewModel: FilterSelectorViewModel!
    
    // Mark: - Controller Related Variables
    var selectedTitles = [String]()
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Navigation
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            if self.selectedTitles.count > 0 {
                viewModel.delegate?.didSelect(currencyNames: self.selectedTitles)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.selectionList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterSelecterTableViewControllerCell", for: indexPath)
        cell.textLabel?.text = self.viewModel.selectionList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedTitles.append(self.viewModel.selectionList[indexPath.row])
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.selectedTitles.removeAll(where: {$0 == self.viewModel.selectionList[indexPath.row]})
    }
}
