//
//  BaseTabBarViewController.swift
//  switchPriceKana
//
//  Created by Woohyun Kim on 2020/09/26.
//  Copyright © 2020 Woohyun Kim. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    var userDatas = [UserData]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

struct UserData{
    var recordTitle: String
    var recordCountryName: String
    var recordMinPrice: String
    static var recordTime: String {
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        return "\(dateTimeComponents.year!)/\(dateTimeComponents.month!)/\(dateTimeComponents.day!)"
    }
}
