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
    
    
    var searchedGameTitle = ""
    var currentMinPriceLabel = ""
    var currentCurrency = ""
    
    let db = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        targetPriceTF.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        searchedGame.text = gameTitelForChart
        currentCurrencyAlarm.text = currencyForAlarm
        currentPriceLabel.text = priceForAlarm
        targetCurrencyAlarm.text = currencyForAlarm
        
        alarmRequestButton.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func TFediting(_ sender: Any) {
        alarmRequestButton.isHidden = false
        alarmStatusIson = true
    }
    
    @IBAction func alarmRequestClicked(_ sender: Any) {
        
        if targetPriceTF.text?.isEmpty == false {
            print("userToken print\(userToken)")
            db.child("token \(userToken)").setValue(["game": "\(gameTitelForChart)", "currency": "\(currencyForAlarm)", "price": "\(String(describing: targetPriceTF.text))"])
          
            SCLAlertView().showSuccess("Price alarm start", subTitle: "When the target price is reached, we will send you a push notification")
        }else{
            SCLAlertView().showError("Target price empty", subTitle: "Please fill in price target")
        }
        
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
