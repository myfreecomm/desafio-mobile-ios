//
//  WebViewModel.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

class WebViewModel {
    
    var pullRequest: PullRequest?
    
    var url : URL?
    var didFail = false
    var isProcessing = false
    
    var didLaunchUrl: ((String) -> Void)?
    
    func launchUrl() {
        
        // Load
        if  let safePull = self.pullRequest,
            let safeUrl = URL(string: safePull.htmlUrl) {
            url = safeUrl
            didLaunchUrl?(safePull.title)
        }
    }
}
