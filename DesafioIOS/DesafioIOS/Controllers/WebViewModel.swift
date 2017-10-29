//
//  WebViewModel.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

/**
 *  WebViewModel
 *  @description    WebViewController's View Model
 */
class WebViewModel {
    
    /**
     * Pull Request reference
     */
    var pullRequest: PullRequest?
    
    /**
     * Failing state
     */
    var didFail = false
    
    /**
     * Processing state
     */
    var isProcessing = false
    
    /**
     * Launch URL Completion
     */
    var didLaunchUrl: ((String) -> Void)?
    
    /**
     *  launchUrl()
     *  @description    Launches URL
     */
    func launchUrl() {
        
        // Load
        if  let safePull = self.pullRequest {
            didLaunchUrl?(safePull.title)
        }
    }
}
