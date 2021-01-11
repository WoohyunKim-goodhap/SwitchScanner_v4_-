//
//  AlarmViewController.swift
//  switchPriceKana
//
//  Created by Woohyun Kim on 2021/01/07.
//  Copyright © 2021 Woohyun Kim. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    
    @IBOutlet var searchedGame: UILabel!
    @IBOutlet var currentCurrencyAlarm: UILabel!
    @IBOutlet var currentPriceLabel: DesignableLabel!
    @IBOutlet var targetCurrencyAlarm: UILabel!
    @IBOutlet var targetPriceTF: UITextField!
    @IBOutlet var explainLabel: UILabel!
    
    
    var searchedGameTitle = ""
    var currentMinPriceLabel = ""
    var currentCurrency = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        targetPriceTF.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        searchedGame.text = searchedGameTitle
        currentCurrencyAlarm.text = currentCurrency
        currentPriceLabel.text = currentMinPriceLabel
        targetCurrencyAlarm.text = currentCurrency
        
        explainLabel.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func TFediting(_ sender: Any) {
        explainLabel.isHidden = false
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

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
