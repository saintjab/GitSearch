//
//  ReadMeViewController.swift
//  GitSearch
//
//  Created by Jonas Boateng on 30/03/2018.
//  Copyright © 2018 Jonas Boateng. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ReadMeViewController: UIViewController, WKNavigationDelegate {
    var progressIndc: UIActivityIndicatorView?
    var readmeUrl: NSURL?
    @IBOutlet weak var webView: WKWebView?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.webView?.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        progressIndc?.stopAnimating()
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        print("didFail")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressIndc?.stopAnimating()
        print("didFinish")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Read Me"
        webView?.navigationDelegate = self
        
        progressIndc = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge, placeInTheCenterOf: self.view)
        progressIndc?.startAnimating()
        
        let request = NSURLRequest(url:readmeUrl! as URL)
        self.webView?.load(request as URLRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
