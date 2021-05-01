//
//  ReaderViewController.swift
//  BookStore
//
//  Created by Sanjay Mali on 01/05/21.
//

import UIKit
import WebKit
class ReaderViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var myWebView:WKWebView!
    var path:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.navigationDelegate = self
        view = myWebView
        let url = URL(string:path ?? "")!
        myWebView.load(URLRequest(url: url))
    }
}
