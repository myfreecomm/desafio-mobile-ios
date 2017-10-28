//
//  WebViewModel.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

class WebViewModel {
    
    weak var viewController : WebViewController?
    
    public var pullRequest: PullRequest?
    
    public var url : URL?
    public var didFail = false
    public var isProcessing = false
    
    func launchUrl() {
        
        // Load
        if  let safePull = self.pullRequest,
            let safeUrl = URL(string: safePull.htmlUrl) {
            
            // Title
            viewController?.title = safePull.title
            viewController?.navigationItem.title = safePull.title
            
            // Loading WebView
            url = safeUrl
            viewController?.loadWebView()
        }
    }
}
