//
//  WebViewController.swift
//  nexaas-desafio-ios
//
//  Created by Rogerio Cervasio on 30/10/17.
//  Copyright © 2017 ACME. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var pull: PullObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = (self.pull?.title)!
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        
        webView.backgroundColor = UIColor.white
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        
        loadAddressURL()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        webView.scrollView.contentInset = UIEdgeInsets.zero
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func loadAddressURL() {
        
        let requestURL = URL(string: (self.pull?.html_url)!)
        
        let request = URLRequest(url: requestURL!)
        
        webView.loadRequest(request)
        
    }
    
    // MARK: - UIWebViewDelegate
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        // Report the error inside the web view.
        let localizedErrorMessage = NSLocalizedString("An error occured:", comment: "")
        
        let errorHTML = "<!doctype html><html><body><div style=\"width: 100%%; text-align: center; font-size: 36pt;\">\(localizedErrorMessage) \(error.localizedDescription)</div></body></html>"
        
        webView.loadHTMLString(errorHTML, baseURL: nil)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
