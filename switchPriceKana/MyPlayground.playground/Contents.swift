import UIKit
import Kanna

var str = "Hello, playground"


///html/body/div/div/div/div[1]/div[1]/article/div/div[3]/ul[3]/li[6]/text()[1]
///html/body/div/div/div/div[1]/div[1]/article/div/div[3]/ul[3]/li[33]/text()[1]


var switchTitles: [String] = []


let itemURLString = "http://www.geekyhobbies.com/nintendo-switch-games-physical-releases-the-complete-list/"
let itemURL = URL(string: itemURLString)!
let itemHTMLString = try? String(contentsOf: itemURL, encoding: .utf8)
let itemDoc = try? HTML(html: itemHTMLString!, encoding: .utf8)
let itemDocBody = itemDoc!.body

print(itemDocBody?.content!)

if let itemNodes = itemDocBody?.xpath("html/body/div/div/div/div[1]/div[1]/article/div/div[3]/ul[3]//text()") {
    print(itemNodes)
    for item in itemNodes {
        print(item.content!)
//        let trimmed = item.content!.trimmingCharacters(in: .whitespacesAndNewlines)
//        switchTitles.append(trimmed)
    }
//    var filtered = switchTitles.filter { $0 != "" }
//    let removeRange = 0 ... 8
//    filtered.removeSubrange(removeRange)
//    switchTitles = filtered
}

