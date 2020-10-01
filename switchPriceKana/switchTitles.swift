//
//  switchTitles.swift
//  switchPriceKana
//
//  Created by Woohyun Kim on 2020/09/29.
//  Copyright © 2020 Woohyun Kim. All rights reserved.
//

import Foundation
import Kanna

var switchTitles: [String] = []


let itemURLString = "https://en.wikipedia.org/wiki/List_of_Nintendo_Switch_games_(A%E2%80%93F)"
let itemURL = URL(string: itemURLString)!
let itemHTMLString = try? String(contentsOf: itemURL, encoding: .utf8)
let itemDoc = try? HTML(html: itemHTMLString!, encoding: .utf8)
let itemDocBody = itemDoc!.body

func getList(){
    if let itemNodes = itemDocBody?.xpath("/html/body/div[3]/div[3]/div[5]/div[1]/table/tbody/tr/th//text()") {
        for item in itemNodes {
            let trimmed = item.content!.trimmingCharacters(in: .whitespacesAndNewlines)
            switchTitles.append(trimmed)
        }
        var filtered = switchTitles.filter { $0 != "" }
        let removeRange = 0 ... 8
        filtered.removeSubrange(removeRange)
        switchTitles = filtered
    }
}
