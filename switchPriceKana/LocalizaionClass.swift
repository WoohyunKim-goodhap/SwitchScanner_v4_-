//
//  LocalizaionClass.swift
//  switchPriceKana
//
//  Created by Woohyun Kim on 2020/10/04.
//  Copyright © 2020 Woohyun Kim. All rights reserved.
//

import Foundation

class LocalizaionClass {
    class Placeholder{
        static let searchBarPlaceholder = NSLocalizedString("SwitchViewController.seachBar.Placeholder", comment: "")
    }
    
    class DetailViewText{
        static let textViewPurchase = NSLocalizedString("DetalViewController.textView.text", comment: "")
    }
    
    class SCalertText{
        static let error = NSLocalizedString("SwitchViewController.SCalert.Error", comment: "")
        static let errorDetail = NSLocalizedString("SwitchViewController.SCalert.ErrorDetail", comment: "")
    }
    
    class SCalertTextForSwitch{
        static let findInMenu = NSLocalizedString("SwitchViewController.SCalert.findInMenu", comment: "")
    }
    
    class WebChartText{
        static let goToChart = NSLocalizedString("WebChartViewController.goToChart.text", comment: "")
        static let errorGuide = NSLocalizedString("WebChartViewController.errorGuideLabel.text", comment: "")
    }
    
    class AVCAlert{
        static let successHead = NSLocalizedString("AlarmViewController.showSuccess.head", comment: "")
        static let successSub = NSLocalizedString("AlarmViewController.showSuccess.sub", comment: "")
        static let errorHead = NSLocalizedString("AlarmViewController.showError.head", comment: "")
        static let errorSub = NSLocalizedString("AlarmViewController.showError.sub", comment: "")
    }
    
    class AVCLabels{
        static let selectedGame = NSLocalizedString("AlarmViewController.selectedGame", comment: "")
        static let currentPrice = NSLocalizedString("AlarmViewController.currentPrice", comment: "")
        static let TargetPrice = NSLocalizedString("AlarmViewController.TargetPrice", comment: "")
        static let alarmRequestButton = NSLocalizedString("AlarmViewController.alarmRequestButton", comment: "")
    }
    
}

