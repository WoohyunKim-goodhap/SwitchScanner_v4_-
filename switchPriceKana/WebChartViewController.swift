//
//  WebChartViewController.swift
//  switchPriceKana
//
//  Created by Woohyun Kim on 2020/10/14.
//  Copyright © 2020 Woohyun Kim. All rights reserved.
//

import UIKit
import WebKit
import Kanna

class WebChartViewController: UIViewController {


    @IBOutlet var coverView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let webViewController = WebViewController()

        addChild(webViewController)
        let webViewControllerView = webViewController.view!
        view.addSubview(webViewControllerView)

        webViewControllerView.translatesAutoresizingMaskIntoConstraints = false
        webViewControllerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = false
        webViewControllerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = false
        webViewControllerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = false
        webViewControllerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = false
        webViewController.didMove(toParent: self)

    }

}



class WebViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
    
    var webView: WKWebView!
    var webViewContentIsLoaded = false

    init() {
        super.init(nibName: nil, bundle: nil)

        self.webView = {

            let contentController = WKUserContentController()

            contentController.add(self, name: "WebViewControllerMessageHandler")

            let configuration = WKWebViewConfiguration()
            configuration.userContentController = contentController

            let webView = WKWebView(frame: .zero, configuration: configuration)
            webView.scrollView.bounces = false
            webView.navigationDelegate = self

            return webView
        }()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)

        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !webViewContentIsLoaded {
            let url = URL(string: "https://eshop-prices.com/games/2872-luigi-s-mansion-3?currency=KRW")!
            let request = URLRequest(url: url)

            webView.load(request)
            webViewContentIsLoaded = true
            
        }
    }
    

    private func evaluateJavascript(_ javascript: String, sourceURL: String? = nil, completion: ((_ error: String?) -> Void)? = nil) {
        var javascript = javascript

        // Adding a sourceURL comment makes the javascript source visible when debugging the simulator via Safari in Mac OS
        if let sourceURL = sourceURL {
            javascript = "//# sourceURL=\(sourceURL).js\n" + javascript
        }

        webView.evaluateJavaScript(javascript) { _, error in
            completion?(error?.localizedDescription)
        }
    }

    // MARK: - WKNavigationDelegate

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        // This must be valid javascript!  Critically don't forget to terminate statements with either a newline or semicolon!
        let javascript =
            "var outerHTML = document.documentElement.outerHTML.toString()\n" +
            "var message = {\"type\": \"outerHTML\", \"outerHTML\": outerHTML }\n" +
            "window.webkit.messageHandlers.WebViewControllerMessageHandler.postMessage(message)\n"

        evaluateJavascript(javascript, sourceURL: "getOuterHMTL")
    }

    // MARK: - WKScriptMessageHandler

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        guard let body = message.body as? [String: Any] else {
            print("could not convert message body to dictionary: \(message.body)")
            return
        }

        guard let type = body["type"] as? String else {
            print("could not convert body[\"type\"] to string: \(body)")
            return
        }

        switch type {
        case "outerHTML":
            guard let outerHTML = body["outerHTML"] as? String else {
                print("could not convert body[\"outerHTML\"] to string: \(body)")
                return
            }
            let itemDoc = try? HTML(html: outerHTML, encoding: .utf8)
            let itemDocBody = itemDoc!.body
            
            //g[2] -> price
            //g[3] -> date
            if let items = itemDocBody?.xpath("/html/body/div[2]/div[2]/div/div/svg/g[2]//text()") {
                chartPrices.removeAll()
                for item in items {
                    let doublePrice = Double(item.content!)
                    chartPrices.append(doublePrice!)
                }
            }
            print("userContentController in \(chartPrices)")
            
            if let items = itemDocBody?.xpath("/html/body/div[2]/div[2]/div/div/svg/g[3]//text()") {
                for item in items {
                    dateSeparator.append(item.text!)
                }
            }
            print("dateSeparator in \(dateSeparator)")
            
        //x축은 날짜 4개로만 구분 y축은 price 값으로 그래프 그리기

        default:
            print("unknown message type \(type)")
            return
        }
    }
    
}

