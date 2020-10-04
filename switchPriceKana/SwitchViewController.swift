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

//[]스위치 게임리스트를 가져오고, lowercase로 필터링 할 것
//[]영어로 내용 바꾸고 런칭도 전세계로 할 것
//[]한글화 localization은 2.0에서 추가 우선 영어로
//[]SearchTVC에서 검색한 결과를 클릭하면 바로 검색되도록 구현


class SwitchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let db = Database.database().reference().child("searchHistory")

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var searchedGemeTitle: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var menuView: UIView!
    @IBOutlet var menuButton: UIButton!
    @IBOutlet var menuViewContraints: NSLayoutConstraint!
    
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        if menuView.isHidden == true{
            menuView.isHidden = false
            showAnimation()
        }else {
            menuView.isHidden = true
            prepareAnimation()
        }
    }
    
    var countryArray = [String]()
    var noDigitalCountryArray = [String]()
    var priceArray = [String]()
    var trimmedPriceArray = [String]()
    var gameTitle: String = ""
    var totalGameList: [String] = Array()
    var selectDatas = [UserData]()
    var currency = "USD"

    // 각 테이블 별 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return noDigitalCountryArray.count
    }

    //각 테이블 별 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else { return UITableViewCell()}
            cell.countryLabel.text = noDigitalCountryArray[indexPath.row]
        
        //여기서 fatal error index out range
            cell.priceLabel.text = priceArray[indexPath.row]
            cell.flagimg.image = UIImage(named: countryNames.key(from: noDigitalCountryArray[indexPath.row]) ?? "")
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //price cell 눌렀을 때
        let selectedData = UserData(recordTitle: gameTitle, recordCountryName: noDigitalCountryArray[indexPath.row], recordMinPrice: priceArray[indexPath.row])
        selectDatas.append(selectedData)
            performSegue(withIdentifier: "showRecord", sender: nil)
    }
    
    var countryPrice: [String: String] = [:]
    var array = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        menuView.isHidden = true
        prepareAnimation()
    }
    
    private func prepareAnimation(){
        menuViewContraints.constant = -60
    }
    
    private func showAnimation(){
        menuViewContraints.constant = 5
        UIView.animate(withDuration: 0.2) {self.view.layoutIfNeeded()}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let rvc = segue.destination as? RecordViewController {
            rvc.userDatas = selectDatas
        }
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
    }
}

class ListCell: UITableViewCell {
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet var flagimg: UIImageView!
}

//search 관련 구문
extension SwitchViewController: UISearchBarDelegate {
    
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
      
    func search(term: String) {
            getCountryNames()
            var titleUrl = [String]()
            let noEmptyWithloweredTerm = term.replacingOccurrences(of: " ", with: "+").lowercased()
        
            let myURLString = "https://eshop-prices.com/games?q=\(noEmptyWithloweredTerm)"
            guard let addPercentURL = myURLString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) else { return }
            guard let myURL = URL(string: addPercentURL) else {return}
            let myHTMLString = try? String(contentsOf: myURL, encoding: .utf8)
            let preDoc = try? HTML(html: myHTMLString!, encoding: .utf8)
            
            for link in preDoc!.xpath("//a/@href") {
                if !link.content!.contains("https") {
                    titleUrl.removeAll()
                    titleUrl.append(link.content!)
                }
            }
            guard let firstUrl = titleUrl.first else { return }
            let itemURLString = "https://eshop-prices.com/\(firstUrl)?currency=\(currency)"
            guard let itemURL = URL(string: itemURLString) else {return}
            let itemHTMLString = try? String(contentsOf: itemURL, encoding: .utf8)
            let itemDoc = try? HTML(html: itemHTMLString!, encoding: .utf8)
            let itemDocBody = itemDoc!.body
        
            if let itemNodesForCountry = itemDocBody?.xpath("/html/body/div[1]/div[2]/div/h1/text()") {
                for item in itemNodesForCountry {
                    if let itemText = item.text{
                        gameTitle = itemText
                    }
                }
            }
            
            if let itemNodesForCountry = itemDocBody?.xpath("/html/body/div[2]/div[1]/table/tbody//td/text()") {
                for country in itemNodesForCountry {
                    if country.content!.count > 0 {
                        let trimmedCountry = country.content!.trimmingCharacters(in: .whitespacesAndNewlines)
                        if onlyCountryNames.contains(trimmedCountry){
                            countryArray.append(trimmedCountry)
                        }
                    }
                }
                noDigitalCountryArray = countryArray.filter { $0 != "Digital code available at Eneba" }
            }
            print(trimmedPriceArray)
            trimmedPriceArray.removeAll()
            print(trimmedPriceArray)

            if let discountedPrice = itemDocBody?.xpath("/html/body/div[2]/div[1]/table/tbody//div/text()") {
                for price in discountedPrice{
                    let trimmedPrice = price.content!.trimmingCharacters(in: .whitespacesAndNewlines)
                    trimmedPriceArray.append(trimmedPrice)
                }
                let onlyPriceArray = trimmedPriceArray.filter{ $0 != "List continues after this ad" && $0 != "" }
                priceArray.append(contentsOf: onlyPriceArray)
            }
            if let originalPrice = itemDocBody?.xpath("/html/body/div[2]/div[1]/table/tbody//td[4]/text()") {
                for price in originalPrice{
                    let trimmedPrice = price.content!.trimmingCharacters(in: .whitespacesAndNewlines)
                    trimmedPriceArray.append(trimmedPrice)
                }
                let onlyPriceArray = trimmedPriceArray.filter{ $0 != "List continues after this ad" && $0 != "" }
                priceArray.append(contentsOf: onlyPriceArray)
            }
        
            if let itemImage = itemDocBody?.at_xpath("/html/body/div[1]/div[2]/picture/img/@src") {
                let url = URL(string: itemImage.content!)
                imgView.kf.setImage(with: url)
            }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let allowedCharacters = "QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890-\n "
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: text)
        
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else {return}
        print("seachButtonClicked\(priceArray)")
        priceArray.removeAll()
        print("seachButtonClickedAndRemoveAll\(priceArray)")

        countryArray.removeAll()
        noDigitalCountryArray.removeAll()
    
        search(term: searchTerm)
        print("seachButtonClickedAfterSearch\(priceArray)")

        self.db.childByAutoId().setValue(searchTerm)
        
        searchedGemeTitle.text = gameTitle
        self.tableView.reloadData()
        
        if noDigitalCountryArray.count < 1 {
            SCLAlertView().showError("검색결과가 없습니다", subTitle: "게임명을 다시 확인해주세요")
        }
    }
}


        
