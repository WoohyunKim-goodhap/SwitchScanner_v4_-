//
//  ViewController.swift
//  switchPriceKana
//
//  Created by Woohyun Kim on 2020/09/12.
//  Copyright © 2020 Woohyun Kim. All rights reserved.
//

import UIKit
import Kanna
import SCLAlertView
import Firebase
import Kingfisher

// * 나중에 업데이트 및 알림 기능을 구현할 때 DB가 필요, 지금은 앱내에서 그대로 값만 보여주는 것으로 런칭
//[] 패캠 강의 중 Firebase 처음부터 들으면서 현재 프로젝트에 신규 DB 연결
//[] Firebase 101 수업과 같이 '읽기, 쓰기, 지우기, 업데이트' viewContrßoller에 만들기
//[] 게임타이틀을 textField가 아니라 스크롤 해서 선택할 수 있도록
//[] 최종적으로는 검색창에 단어를 입력하면 관련 타이틀을 노출
//[]국기이미지는 flagpedia에서 다운로드 -> assets에 넣을 것 -> 국기 파일명을 countryArray와 동일하게 맞추어 주어야 함 -> ML을 활용?
//[]currency 변경 옵션 추가 -> 리스트로 선택할 수 있도록
//[]fire base 혹은 로컬 파일로 즐겨찾는 타이틀 저장할 수 있게하자

// * ver.1 단순하게 보여주는 형태
// [O](1)user가 검색창에 게임 타이틀을 쓰면 -> [o](2)searchTitle로 읽어 옴 -> [o](3)searchTitle로 countryPrice dictionary를 산출 -> [o](4)value가 낮은 순서대로 보여 줌
//[O](1) 검색창 -> 강의 내용 중 검색 창있었던 강의 참고, 넷플릭스? 그 전에도 있었음
// -[O]테이블뷰 셀은 /가격/국가명 순으로

//[O](3) countryPrice를 보여주는 tableViewCell이 필요 reuse해야할 것임
//[o]대소문자는 상관 없는 듯. for loop와 enumerate character를 사용하여 공백은 "+"로 바꿔줄 것
//[o]searchTitle로 검색어 전달

//[O]셀 클릭시 모달뷰로 구매방법 설명 띄우기(현상금 랭킹앱 참조)
//[O]검색어 오류, 검색 결과 없을 때 띄울 모달뷰 만들기(현상금 랭킹앱 참조)
//[O]타이틀에 'switch'넣고 밑에 한글 헤더 달기
//[0]fire base 연결하기
//[0]다크모드 적용
//[0]국기 json 활용해서 앞에 추가
//[0]게임 아이콘 만들기
//[]검색 scene에 게임타이틀 label 추가
//[]해당 국가 셀을 클릭하면 '저장되었습니다. 기록 탭에서 확인 팝업' + 클릭한 셀의 정보를 기록 scene으로 전달하기 위해서는 "Swift4: Sharing Data Model across Views in Tab Bar Controller" 유투브 확인
//[]빈 book label을 클릭하면 기록 scene으로 데이터 전달+꽉찬 이미지로 변경
//[]booking한 데이터는 기기에 저장?(filemanager가 app에도 적용되는지 확인)
//[]구매방법, 사용설명 페이지는 별도의 tab var로 분리
//[]기록scene의 셀을 스와이프하면 삭제할 수 있도록하고, 위치 조정도 추가(<-애플 도서 참고)

class SwitchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let db = Database.database().reference().child("searchHistory")
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imgView: UIImageView!
    
    
    var countryArray = [String]()
    var noDigitalCountryArray = [String]()
    var priceArray = [String]()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noDigitalCountryArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        cell.countryLabel.text = noDigitalCountryArray[indexPath.row]
        cell.priceLabel.text = priceArray[indexPath.row]
        cell.flagimg.image = UIImage(named: countryNames.key(from: noDigitalCountryArray[indexPath.row]) ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SCLAlertView().showInfo("저장되었습니다", subTitle: "기록 탭을 확인해주세요")
    }

    var countryPrice: [String: String] = [:]
    var array = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


class ListCell: UITableViewCell {
//    @IBOutlet weak var flagView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet var flagimg: UIImageView!
    
}

extension SwitchViewController: UISearchBarDelegate {
    
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
      
    func search(term: String) {
            var titleUrl: String = ""
            let currency = "₩"
            let noEmptyWithloweredTerm = term.replacingOccurrences(of: " ", with: "+").lowercased()
        
            let myURLString = "https://eshop-prices.com/games?q=\(noEmptyWithloweredTerm)"
            let myURL = URL(string: myURLString)
            let myHTMLString = try? String(contentsOf: myURL!, encoding: .utf8)
            let preDoc = try? HTML(html: myHTMLString!, encoding: .utf8)
            
            for link in preDoc!.xpath("//a/@href") {
                if !link.content!.contains("https") {
                    titleUrl = link.content!
                }
            }
            let itemURLString = "https://eshop-prices.com/\(titleUrl)?currency=KRW"
            let itemURL = URL(string: itemURLString)!
            let itemHTMLString = try? String(contentsOf: itemURL, encoding: .utf8)
            let itemDoc = try? HTML(html: itemHTMLString!, encoding: .utf8)
            let itemDocBody = itemDoc!.body
            
            if let itemNodesForCountry = itemDocBody?.xpath("/html/body/div[2]/div[1]/table/tbody//td/text()") {
                for country in itemNodesForCountry {
                    if country.content!.count > 2 && !country.content!.contains("₩") {
                        let trimmedCountry = country.content!.trimmingCharacters(in: .whitespacesAndNewlines)
                        countryArray.append(trimmedCountry)
                    }
                }
                noDigitalCountryArray = countryArray.filter { $0 != "Digital code available at Eneba" }
                print(noDigitalCountryArray)
            }
            
            if let itemNodesForPrice2 = itemDocBody?.xpath("/html/body/div[2]/div[1]/table/tbody//div/text()") {
                for price in itemNodesForPrice2 {
                    let trimmedPrice = price.content!.trimmingCharacters(in: .whitespacesAndNewlines)
                    if trimmedPrice.hasPrefix(currency){
                        priceArray.append(trimmedPrice)
                    }
                }
            }
            if let itemNodesForPrice1 = itemDocBody?.xpath("/html/body/div[2]/div[1]/table/tbody//td[4]/text()") {
                for price in itemNodesForPrice1 {
                    let trimmedPrice = price.content!.trimmingCharacters(in: .whitespacesAndNewlines)
                    if trimmedPrice.hasPrefix(currency){
                        priceArray.append(trimmedPrice)
                    }
                }
            }
        
            if let itemImage = itemDocBody?.at_xpath("/html/body/div[1]/div[2]/picture/img/@src") {
                let url = URL(string: itemImage.content!)
                imgView.kf.setImage(with: url)
            }


    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else {return}
        
        priceArray.removeAll()
        countryArray.removeAll()
        noDigitalCountryArray.removeAll()

    
        search(term: searchTerm)
        self.db.childByAutoId().setValue(searchTerm)
        
        self.tableView.reloadData()
        
        if noDigitalCountryArray.count < 1 {
            SCLAlertView().showError("검색결과가 없습니다", subTitle: "게임명을 다시 확인해주세요")
        }
    }
}


        
