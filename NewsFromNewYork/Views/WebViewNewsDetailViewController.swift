//
//  WebViewNewsDetailViewController.swift
//  NewsFromNewYork
//
//  Created by prasanth on 03/07/22.
//

import UIKit
import WebKit

class WebViewNewsDetailViewController: UIViewController {
    
    let webView = WKWebView()
    var urString: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(webView)
        loadWeView()
    }
    
    func loadWeView() {
        webView.navigationDelegate = self
        // Monitoring page loads
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        guard let url = urString else { return }
        webView.load(url)
    }
}

// MARK: - WKNavigationDelegate
extension WebViewNewsDetailViewController : WKNavigationDelegate {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print(Float(webView.estimatedProgress))
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("LOADED CONTENT")
    }
}
