//
//  WebViewController.swift
//  Extension
//
//  Created by lihong on 2020/12/14.
//  Copyright © 2020 lihong. All rights reserved.
//

import UIKit
import WebKit

public class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    let navigationTitle: String
    let urlRequest: URLRequest
    
    @IBOutlet var webView: WKWebView!
    
    public init?(_ title: String, url: URL) {
        navigationTitle = title
        self.urlRequest = URLRequest(url: url)
        super.init(nibName: "WebViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navigationTitle

//        webView.uiDelegate = self
//        webView.navigationDelegate = self
        webView.load(urlRequest)
    }

    // MARK : - WKUIDelegate, WKNavigationDelegate
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url,
                !url.absoluteString.hasPrefix("http://"),
                !url.absoluteString.hasPrefix("https://"),
                UIApplication.shared.canOpenURL(url) {
                // have UIApplication handle the url (sms:, tel:, mailto:, ...)
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                // cancel the request (handled by UIApplication)
                decisionHandler(.cancel)
            }
            else {
                // allow the request
                decisionHandler(.allow)
            }
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        handleError(error)
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        handleError(error)
    }
    
     
    func handleError(_ error: Error) {
        let error = error as NSError
        guard let failingUrl = error.userInfo["NSErrorFailingURLStringKey"] as? String,
              let url = URL(string: failingUrl) else {
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

}
