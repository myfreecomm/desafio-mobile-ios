//
//  WebViewController.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var url:NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
}
