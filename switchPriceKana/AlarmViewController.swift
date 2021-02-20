//
//  AlarmViewController.swift
//  switchPriceKana
//
//  Created by Woohyun Kim on 2021/02/06.
//  Copyright © 2021 Woohyun Kim. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase

class AlarmViewController: UIViewController {
    
    @IBOutlet var searchedGame: UILabel!
    @IBOutlet var currentCurrencyAlarm: UILabel!
    @IBOutlet var currentPriceLabel: UILabel!
    @IBOutlet var targetCurrencyAlarm: UILabel!
    @IBOutlet var targetPriceTF: UITextField!
    @IBOutlet var alarmRequestButton: UIButton!
    
    
    @IBOutlet var selectedGame: UILabel!
    @IBOutlet var currentPrice: UILabel!
    @IBOutlet var TargetPrice: UILabel!
    
    
    var searchedGameTitle = ""
    var currentMinPriceLabel = ""
    var currentCurrency = ""
    
    let db = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alarmRequestButton.setTitle(LocalizaionClass.AVCLabels.alarmRequestButton, for: .normal)
        selectedGame.text = LocalizaionClass.AVCLabels.selectedGame
        currentPrice.text = LocalizaionClass.AVCLabels.currentPrice
        TargetPrice.text = LocalizaionClass.AVCLabels.TargetPrice
        
        targetPriceTF.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        searchedGame.text = gameTitelForChart

        
        alarmRequestButton.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func TFediting(_ sender: Any) {
        alarmRequestButton.isHidden = false
    }
    
    @IBAction func alarmRequestClicked(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
