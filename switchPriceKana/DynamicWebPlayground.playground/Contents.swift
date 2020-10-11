import UIKit
import Kanna
import Foundation
import WebKit


// x 축은 모두 20~262 까지
// y 축은 모두 160-0 까지

// [] eshop에서 미국 price 읽어오는 것부터 시작
// [] 날짜 정보(x)축 레이블로 먼저 읽어 와 보고, 다른 게임에도 적용해 볼 것. 최신 게임일 경우 레이블이 다름
// [] 화폐 단위에 따라 표시되는 수치가 다름. 일단은 있는 숫자 그대로 읽어 옴
// [] charts 라이브러리 설치에서 앉혀 봄

///html/body/div[2]/div[2]/div/div/svg/g[2]/g/circle[5]
///html/body/div[2]/div[2]/div/div


var webView: WKWebView!
var currency = "USD"
var title = "5218-hades"

let itemURLString = "https://eshop-prices.com/games/\(title)?currency=\(currency)"
let itemURL = URL(string: itemURLString)
//let session = URLSession.shared
//let task = session.dataTask(with: itemURL! as URL, completionHandler: {(data, response, error) -> Void in
//
//    if error == nil {
//        let urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//        print(urlContent ?? "No contents found")
//    }else{
//        print("Error occurred\(error?.localizedDescription)")
//    }
//})
//task.resume()



let itemHTMLString = try? String(contentsOf: itemURL!, encoding: .utf8)
let itemDoc = try? HTML(html: itemHTMLString!, encoding: .utf8)
let itemDocBody = itemDoc?.body

let coordinate = itemDocBody!.at_css("body > div.wrapper.main-wrapper > div.side-well > div > div > svg > g:nth-child(2) > g > circle:nth-child(35)")

print(coordinate)

//webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
//                           completionHandler: { (html: Any?, error: Error?) in
//    print(html)
//})





