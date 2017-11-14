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
     * Pull Request Title
     */
    var pullRequestTitle : String {
        get {
            return pullRequest.title
        }
    }
    
    /**
     * Pull Request URL
     */
    var pullRequestUrl : URL? {
        get {
            return pullRequest.htmlUrl
        }
    }
    
    /**
     * Failing state
     */
    var didFail = false
    
    /**
     * Processing state
     */
    var isProcessing = false
    
    /**
     * Pull Request reference
     */
    fileprivate var pullRequest: PullRequest
    
    
    // MARK: - 👽 Lifecycle Methods
    
    
    /**
     * Constructor
     */
    init(pullRequest: PullRequest) {
        self.pullRequest = pullRequest
    }
}


