//
//  PullRequestsViewModel.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

/**
 *  PullRequestsViewModel
 *  @description    PullRequestsViewController's View Model
 */
class PullRequestsViewModel {
    
    /**
     * Repository to fetch Pull Requests
     */
    var repository : Repository
    
    /**
     * Repository's name
     */
    var repositoryName : String {
        get {
            return repository.name
        }
    }
    
    /**
     * Pull Request Micro Service
     */
    fileprivate var service = PullRequestService()
    
    /**
     * Pull Request Micro Service
     */
    fileprivate(set) var source = [PullRequest]()
    
    /**
     * Processing State
     */
    fileprivate(set) var isProcessing = false
    
    /**
     * Open Pulls count
     */
    fileprivate(set) var openPullsCount = 0
    
    /**
     * Closed Pulls count
     */
    fileprivate(set) var closedPullsCount = 0
    
    
    // MARK: - 👽 Lifecycle Methods
    
    /**
     * Constructor
     */
    init(repository: Repository) {
        self.repository = repository
    }
    
    
    // MARK: - 🔐 Common Methods
    
    
    /**
     *  refresh()
     *  @description    Toggles processing state & reset the data
     */
    func refresh() {
        guard !isProcessing else { return }
        isProcessing = true
        // Re-fetch
        fetchData()
    }
    
    /**
     *  fetchData(completion:)
     *  @description        Fires Pull Request micro service request
     *  @param completion   Callback fired when request is completed
     */
    func fetchData(completion: (() -> Void)?=nil) {
        
        // Required data
        guard let safeOwner = repository.owner else {
            NotificationCenter.default.post(.didReceiveError, object: "Error.FailedRepositoryRequest".localized)
            completion?()
            return
        }
        
        // Send request
        service.load(owner: safeOwner.username, repository: repository.name, succeed: { [weak self] results in
            
            guard let this = self else { return }
            
            // Check state
            for pull in results {
                // Open pulls
                if  pull.state == "open" {
                    this.openPullsCount += 1
                }
                // Closed pulls
                if  pull.state == "closed" {
                    this.closedPullsCount += 1
                }
            }
            
            // Fill label
            NotificationCenter.default.post(.preparePullsCount)
            
            // Fill source
            this.source = results
            this.isProcessing = false
            NotificationCenter.default.post(.reloadData)
            completion?()
            
        }) { [weak self] errorDescription in
            
            guard let this = self else { return }
            
            // Show error
            this.isProcessing = false
            NotificationCenter.default.post(.didReceiveError, object: errorDescription)
            completion?()
        }
    }
}

