//
//  DetailViewController.swift
//  switchPriceKana
//
//  Created by Woohyun Kim on 2020/09/16.
//  Copyright © 2020 Woohyun Kim. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var DetaliTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DetaliTextView.text = LocalizaionClass.DetailViewText.textViewPurchase
        // Do any additional setup after loading the view.
    }
}
