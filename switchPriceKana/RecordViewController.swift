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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return userDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as? RecordCell else {
            return UITableViewCell()
        }
//        let tabBar = BaseTabBarViewController()
 
//        cell.recordCountryName.text = "123"
//        cell.recordMinPrice.text = "456"
//        cell.recordTitle.setTitle(tabBar.userDatas[indexPath.row].recordTitle, for: .normal)
        
        cell.recordCountryName.text = userDatas[indexPath.row].recordCountryName
        cell.recordMinPrice.text = userDatas[indexPath.row].recordMinPrice
        cell.recordTitle.setTitle(userDatas[indexPath.row].recordTitle, for: .normal)

        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(userDatas)
    }
    
    func updatUI() {
        
    }
    
    @IBAction func saveSegue(segue: UIStoryboardSegue) {
    }
    
}

class RecordCell: UITableViewCell {
    @IBOutlet weak var recordTitle: UIButton!
    @IBOutlet weak var recordCountryName: UILabel!
    @IBOutlet weak var recordMinPrice: UILabel!
    @IBOutlet weak var recordTime: UILabel!
}

