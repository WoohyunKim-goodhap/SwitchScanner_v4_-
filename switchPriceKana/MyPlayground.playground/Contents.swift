import UIKit
import Kanna

let countryNames = [ "ad": "Andorra",
"ae": "United Arab Emirates",
"af": "Afghanistan",
"ag": "Antigua and Barbuda",
"ai": "Anguilla",
"al": "Albania",
"am": "Armenia",
"ao": "Angola",
"aq": "Antarctica",
"ar": "Argentina",
"as": "American Samoa",
"at": "Austria",
"au": "Australia",
"aw": "Aruba",
"ax": "Åland Islands",
"az": "Azerbaijan",
"ba": "Bosnia and Herzegovina",
"bb": "Barbados",
"bd": "Bangladesh",
"be": "Belgium",
"bf": "Burkina Faso",
"bg": "Bulgaria",
"bh": "Bahrain",
"bi": "Burundi",
"bj": "Benin",
"bl": "Saint Barthélemy",
"bm": "Bermuda",
"bn": "Brunei",
"bo": "Bolivia",
"bq": "Caribbean Netherlands",
"br": "Brazil",
"bs": "Bahamas",
"bt": "Bhutan",
"bv": "Bouvet Island",
"bw": "Botswana",
"by": "Belarus",
"bz": "Belize",
"ca": "Canada",
"cc": "Cocos (Keeling) Islands",
"cd": "DR Congo",
"cf": "Central African Republic",
"cg": "Republic of the Congo",
"ch": "Switzerland",
"ci": "Côte d'Ivoire (Ivory Coast)",
"ck": "Cook Islands",
"cl": "Chile",
"cm": "Cameroon",
"cn": "China",
"co": "Colombia",
"cr": "Costa Rica",
"cu": "Cuba",
"cv": "Cape Verde",
"cw": "Curaçao",
"cx": "Christmas Island",
"cy": "Cyprus",
"cz": "Czechia",
"de": "Germany",
"dj": "Djibouti",
"dk": "Denmark",
"dm": "Dominica",
"do": "Dominican Republic",
"dz": "Algeria",
"ec": "Ecuador",
"ee": "Estonia",
"eg": "Egypt",
"eh": "Western Sahara",
"er": "Eritrea",
"es": "Spain",
"et": "Ethiopia",
"eu": "European Union",
"fi": "Finland",
"fj": "Fiji",
"fk": "Falkland Islands",
"fm": "Micronesia",
"fo": "Faroe Islands",
"fr": "France",
"ga": "Gabon",
"gb": "United Kingdom",
"gb-eng": "England",
"gb-nir": "Northern Ireland",
"gb-sct": "Scotland",
"gb-wls": "Wales",
"gd": "Grenada",
"ge": "Georgia",
"gf": "French Guiana",
"gg": "Guernsey",
"gh": "Ghana",
"gi": "Gibraltar",
"gl": "Greenland",
"gm": "Gambia",
"gn": "Guinea",
"gp": "Guadeloupe",
"gq": "Equatorial Guinea",
"gr": "Greece",
"gs": "South Georgia",
"gt": "Guatemala",
"gu": "Guam",
"gw": "Guinea-Bissau",
"gy": "Guyana",
"hk": "Hong Kong",
"hm": "Heard Island and McDonald Islands",
"hn": "Honduras",
"hr": "Croatia",
"ht": "Haiti",
"hu": "Hungary",
"id": "Indonesia",
"ie": "Ireland",
"il": "Israel",
"im": "Isle of Man",
"in": "India",
"io": "British Indian Ocean Territory",
"iq": "Iraq",
"ir": "Iran",
"is": "Iceland",
"it": "Italy",
"je": "Jersey",
"jm": "Jamaica",
"jo": "Jordan",
"jp": "Japan",
"ke": "Kenya",
"kg": "Kyrgyzstan",
"kh": "Cambodia",
"ki": "Kiribati",
"km": "Comoros",
"kn": "Saint Kitts and Nevis",
"kp": "North Korea",
"kr": "South Korea",
"kw": "Kuwait",
"ky": "Cayman Islands",
"kz": "Kazakhstan",
"la": "Laos",
"lb": "Lebanon",
"lc": "Saint Lucia",
"li": "Liechtenstein",
"lk": "Sri Lanka",
"lr": "Liberia",
"ls": "Lesotho",
"lt": "Lithuania",
"lu": "Luxembourg",
"lv": "Latvia",
"ly": "Libya",
"ma": "Morocco",
"mc": "Monaco",
"md": "Moldova",
"me": "Montenegro",
"mf": "Saint Martin",
"mg": "Madagascar",
"mh": "Marshall Islands",
"mk": "North Macedonia",
"ml": "Mali",
"mm": "Myanmar",
"mn": "Mongolia",
"mo": "Macau",
"mp": "Northern Mariana Islands",
"mq": "Martinique",
"mr": "Mauritania",
"ms": "Montserrat",
"mt": "Malta",
"mu": "Mauritius",
"mv": "Maldives",
"mw": "Malawi",
"mx": "Mexico",
"my": "Malaysia",
"mz": "Mozambique",
"na": "Namibia",
"nc": "New Caledonia",
"ne": "Niger",
"nf": "Norfolk Island",
"ng": "Nigeria",
"ni": "Nicaragua",
"nl": "Netherlands",
"no": "Norway",
"np": "Nepal",
"nr": "Nauru",
"nu": "Niue",
"nz": "New Zealand",
"om": "Oman",
"pa": "Panama",
"pe": "Peru",
"pf": "French Polynesia",
"pg": "Papua New Guinea",
"ph": "Philippines",
"pk": "Pakistan",
"pl": "Poland",
"pm": "Saint Pierre and Miquelon",
"pn": "Pitcairn Islands",
"pr": "Puerto Rico",
"ps": "Palestine",
"pt": "Portugal",
"pw": "Palau",
"py": "Paraguay",
"qa": "Qatar",
"re": "Réunion",
"ro": "Romania",
"rs": "Serbia",
"ru": "Russia",
"rw": "Rwanda",
"sa": "Saudi Arabia",
"sb": "Solomon Islands",
"sc": "Seychelles",
"sd": "Sudan",
"se": "Sweden",
"sg": "Singapore",
"sh": "Saint Helena, Ascension and Tristan da Cunha",
"si": "Slovenia",
"sj": "Svalbard and Jan Mayen",
"sk": "Slovakia",
"sl": "Sierra Leone",
"sm": "San Marino",
"sn": "Senegal",
"so": "Somalia",
"sr": "Suriname",
"ss": "South Sudan",
"st": "São Tomé and Príncipe",
"sv": "El Salvador",
"sx": "Sint Maarten",
"sy": "Syria",
"sz": "Eswatini (Swaziland)",
"tc": "Turks and Caicos Islands",
"td": "Chad",
"tf": "French Southern and Antarctic Lands",
"tg": "Togo",
"th": "Thailand",
"tj": "Tajikistan",
"tk": "Tokelau",
"tl": "Timor-Leste",
"tm": "Turkmenistan",
"tn": "Tunisia",
"to": "Tonga",
"tr": "Turkey",
"tt": "Trinidad and Tobago",
"tv": "Tuvalu",
"tw": "Taiwan",
"tz": "Tanzania",
"ua": "Ukraine",
"ug": "Uganda",
"um": "United States Minor Outlying Islands",
"un": "United Nations",
"us": "United States",
"us-ak": "Alaska",
"us-al": "Alabama",
"us-ar": "Arkansas",
"us-az": "Arizona",
"us-ca": "California",
"us-co": "Colorado",
"us-ct": "Connecticut",
"us-de": "Delaware",
"us-fl": "Florida",
"us-ga": "Georgia",
"us-hi": "Hawaii",
"us-ia": "Iowa",
"us-id": "Idaho",
"us-il": "Illinois",
"us-in": "Indiana",
"us-ks": "Kansas",
"us-ky": "Kentucky",
"us-la": "Louisiana",
"us-ma": "Massachusetts",
"us-md": "Maryland",
"us-me": "Maine",
"us-mi": "Michigan",
"us-mn": "Minnesota",
"us-mo": "Missouri",
"us-ms": "Mississippi",
"us-mt": "Montana",
"us-nc": "North Carolina",
"us-nd": "North Dakota",
"us-ne": "Nebraska",
"us-nh": "New Hampshire",
"us-nj": "New Jersey",
"us-nm": "New Mexico",
"us-nv": "Nevada",
"us-ny": "New York",
"us-oh": "Ohio",
"us-ok": "Oklahoma",
"us-or": "Oregon",
"us-pa": "Pennsylvania",
"us-ri": "Rhode Island",
"us-sc": "South Carolina",
"us-sd": "South Dakota",
"us-tn": "Tennessee",
"us-tx": "Texas",
"us-ut": "Utah",
"us-va": "Virginia",
"us-vt": "Vermont",
"us-wa": "Washington",
"us-wi": "Wisconsin",
"us-wv": "West Virginia",
"us-wy": "Wyoming",
"uy": "Uruguay",
"uz": "Uzbekistan",
"va": "Vatican City (Holy See)",
"vc": "Saint Vincent and the Grenadines",
"ve": "Venezuela",
"vg": "British Virgin Islands",
"vi": "United States Virgin Islands",
"vn": "Vietnam",
"vu": "Vanuatu",
"wf": "Wallis and Futuna",
"ws": "Samoa",
"xk": "Kosovo",
"ye": "Yemen",
"yt": "Mayotte",
"za": "South Africa",
"zm": "Zambia",
"zw": "Zimbabwe" ]

var onlyCountryNames: [String] = []

for i in countryNames.values{
    onlyCountryNames.append(i)
}


var term = "chameleon"
var currency = "KRW"

var countryArray = [String]()
var noDigitalCountryArray = [String]()
var priceArray = [String]()
var gameTitle: String = ""
var totalGameList: [String] = Array()
var trimmedPriceArray = [String]()


var titleUrl = [String]()
let noEmptyWithloweredTerm = term.replacingOccurrences(of: " ", with: "+").lowercased()

let myURLString = "https://eshop-prices.com/games?q=\(noEmptyWithloweredTerm)"
let addPercentURL = myURLString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
let myURL = URL(string: addPercentURL!)
let myHTMLString = try? String(contentsOf: myURL!, encoding: .utf8)
let preDoc = try? HTML(html: myHTMLString!, encoding: .utf8)

for link in preDoc!.xpath("//a/@href") {
    if !link.content!.contains("https") {
        titleUrl.append(link.content!)
    }
}

//svc에서는 firstTitle을 optional binding으로 풀어서 써야함(func 내부이므로 return사용가능)
let itemURLString = "https://eshop-prices.com/\(titleUrl.first!)?currency=\(currency)"
let itemURL = URL(string: itemURLString)
let itemHTMLString = try? String(contentsOf: itemURL!, encoding: .utf8)
let itemDoc = try? Kanna.HTML(html: itemHTMLString!, encoding: .utf8)
let itemDocBody = itemDoc!.body
let itemDocXML = try? Kanna.XML(xml: itemHTMLString!, encoding: .utf8)

if let itemNodesForCountry = itemDocBody?.xpath("/html/body/div[1]/div[2]/div/h1/text()") {
    for item in itemNodesForCountry {
    }
}

//if country.content!.count > 0 && !country.content!.contains("₩")

if let itemNodesForCountry = itemDocBody?.xpath("/html/body/div[2]/div[1]/table/tbody//td/text()") {
    for country in itemNodesForCountry {
        if country.content!.count > 0 {
            let trimmedCountry = country.content!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //수정필요
            if onlyCountryNames.contains(trimmedCountry){
                countryArray.append(trimmedCountry)
            }
        }
    }
    noDigitalCountryArray = countryArray.filter { $0 != "Digital code available at Eneba" }

}

//현재 읽어오는 path
///html/body/div[2]/div[1]/table/tbody/tr[4]/td/div
//
//
//할인 없는 가격
///html/body/div[2]/div[1]/table/tbody/tr[1]/td[4]
///html/body/div[2]/div[1]/table/tbody/tr[5]/td[4]
//
//할인한 가격
///html/body/div[2]/div[1]/table/tbody/tr[2]/td[4]/div/text()
///html/body/div[2]/div[1]/table/tbody/tr[8]/td[4]/div/text()

//할인한 가격

//let discountPrice = itemDoc?.xpath("//tr")
//print(discountPrice)
//print("discountPrice in \(discountPrice)")


///html/body/div[2]/div[1]/table/tbody/tr[1]/td[4]/div/text()
///html/body/div[2]/div[1]/table/tbody/tr[1]/td[4]/div/text()

//let item = itemDocXML!.at_xpath("//tbody//td[4]")
//print(item?.innerHTML)


if let itemHtml = itemDocBody?.xpath("/html/body/div[2]/div[1]/table/tbody//div/text()"){
    for price in itemHtml{
        let trimmedPrice = price.content!.trimmingCharacters(in: .whitespacesAndNewlines)
        trimmedPriceArray.append(trimmedPrice)
    }

    let onlyPriceArray = trimmedPriceArray.filter{ $0 != "List continues after this ad" && $0 != "" }
    priceArray.append(contentsOf: onlyPriceArray)
    print(priceArray)
}




//할인 없는 가격

if let originalPrice = itemDocBody?.xpath("/html/body/div[2]/div[1]/table/tbody//td[4]/text()") {
    for price in originalPrice {
//        let trimmedPrice = price.content!.trimmingCharacters(in: .whitespacesAndNewlines)

        let trimmedPrice = price.content!.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedPrice.hasPrefix(currency){
            priceArray.append(trimmedPrice)
        }
    }
}





