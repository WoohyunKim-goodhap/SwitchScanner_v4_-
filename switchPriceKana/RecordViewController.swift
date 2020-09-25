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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as? RecordCell else {
            return UITableViewCell()
        }


        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

class RecordCell: UITableViewCell {
    @IBOutlet weak var recordTitle: UIButton!
    @IBOutlet weak var recordCountryName: UILabel!
    @IBOutlet weak var recordMinPrice: UILabel!
    @IBOutlet weak var recordTime: UILabel!
}

