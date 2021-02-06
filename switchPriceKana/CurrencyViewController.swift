//
//  CurrencyViewController.swift
//  switchPriceKana
//
//  Created by Woohyun Kim on 2020/10/02.
//  Copyright © 2020 Woohyun Kim. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedCurrency = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencyDic.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyCell else {
            return UITableViewCell()
        }
        cell.currencyCountry.text = currencyCountry[indexPath.row]
        cell.currencyLabel.text = currencyDic[currencyCountry[indexPath.row]]
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let userCurrency = currencyDic[currencyCountry[indexPath.row]]{
            print(userCurrency)
            selectedCurrency = userCurrency
        }
        self.performSegue(withIdentifier: "unwindSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegue"{
            if let svc = segue.destination as? SwitchViewController{
                //SVC에 테이블 셀에 필요 값을 넣어줌
                svc.currency = selectedCurrency
                currencyForAlarm = selectedCurrency
                if svc.searchBar.text?.isEmpty == false{
                    svc.searchBarSearchButtonClicked(svc.searchBar)
                }else{ return }
            }
            //차트뷰에 currency text를 전달
            currencyForChart = selectedCurrency
        }
    }
}

class CurrencyCell: UITableViewCell {
    @IBOutlet var currencyCountry: UILabel!
    @IBOutlet var currencyLabel: UILabel!
}
