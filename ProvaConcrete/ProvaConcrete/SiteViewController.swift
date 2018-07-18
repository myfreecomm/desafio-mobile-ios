//
//  SiteViewController.swift
//  ProvaConcrete
//
//  Created by MacBook Pro i7 on 03/08/17.
//  Copyright © 2017 Claudio. All rights reserved.
//

import UIKit
import WebKit

class SiteViewController: UIViewController,WKNavigationDelegate, WKUIDelegate {

    var site : String = ""
    var prName: String = ""
    
    var ww: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        
        ww.load(URLRequest(url: URL(string: site)!))
        
        title = "Site Pull Request - " + prName
        
    }
    
    override func loadView() {
        super.loadView()
        ww = WKWebView()
        self.ww.navigationDelegate = self
        view = ww
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

