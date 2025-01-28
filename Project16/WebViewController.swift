//
//  WebViewController.swift
//  Project16
//
//  Created by VII on 28.01.2025.
//

import WebKit
import UIKit

class WebViewController: UIViewController {
    var webView: WKWebView!
    var url: URL!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = url else { return }
        webView.load(URLRequest(url: url))
    }
}
