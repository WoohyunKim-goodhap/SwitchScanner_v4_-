//
//  SearchTableViewController.swift
//  switchPriceKana
//
//  Created by Woohyun Kim on 2020/09/29.
//  Copyright © 2020 Woohyun Kim. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {

    
    var filteredData: [String] = []
    var resultSearchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController.searchResultsUpdater = self
        resultSearchController.hidesNavigationBarDuringPresentation = false
        self.tableView.tableHeaderView = resultSearchController.searchBar
        resultSearchController.searchBar.searchBarStyle = UISearchBar.Style.prominent
        resultSearchController.searchBar.sizeToFit()
        self.definesPresentationContext = true
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if resultSearchController.isActive{
            return filteredData.count
        }else{
            return switchTitles.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
        // Configure the cell...
        if resultSearchController.isActive{
            cell.textLabel?.text = filteredData[indexPath.row]
        }else{
            cell.textLabel?.text = switchTitles[indexPath.row]
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
             if (searchController.searchBar.text?.count)! > 0{
                 filteredData.removeAll(keepingCapacity: false)
                 let searchPredicate = NSPredicate(format: "SELF CONTAINS %@", searchController.searchBar.text!)
                 let array = (switchTitles as NSArray).filtered(using: searchPredicate)
                 filteredData = array as! [String]
                 tableView.reloadData()
             }else{
                 filteredData.removeAll(keepingCapacity: false)
                 filteredData = switchTitles
                 tableView.reloadData()
             }
         }
}
