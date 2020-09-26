//
//  RecordViewController.swift
//  switchPriceKana
//
//  Created by Woohyun Kim on 2020/09/25.
//  Copyright © 2020 Woohyun Kim. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var countryName: String?
    var gameTitle: String?
    var price: String?
    
    var userDatas = [UserData]()
    var returnData = String()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return userDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as? RecordCell else {
            return UITableViewCell()
        }

        cell.recordCountryName.text = userDatas[indexPath.row].recordCountryName
        cell.recordMinPrice.text = userDatas[indexPath.row].recordMinPrice
        cell.recordTitle.setTitle(userDatas[indexPath.row].recordTitle, for: .normal)

        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

class RecordCell: UITableViewCell {
    @IBOutlet weak var recordTitle: UIButton!
    @IBOutlet weak var recordCountryName: UILabel!
    @IBOutlet weak var recordMinPrice: UILabel!
    @IBOutlet weak var recordTime: UILabel!
}

