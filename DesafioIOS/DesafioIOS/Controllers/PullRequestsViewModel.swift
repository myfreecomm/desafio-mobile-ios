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
 *  @description    Pull Request's View Model
 */
class PullRequestsViewModel {
    
    /**
     * View Controller weak reference
     */
    weak var viewController : PullRequestsViewController?
    
    /**
     * Repository to fetch Pull Requests
     */
    var repository : Repository?
    
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
        guard
            let safeRepository = repository,
            let safeOwner = safeRepository.owner
            else {
                viewController?.errorHud("Não foi possível carregar os dados desse repositório.")
                viewController?.refreshControl?.endRefreshing()
                completion?()
                return
        }
        
        // Send request
        service.load(owner: safeOwner.username, repository: safeRepository.name, succeed: { [weak self] results in
            
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
            let openText = "\(this.openPullsCount) opened"
            let text = "\(openText) / \(this.closedPullsCount) closed"
            let attrStr = NSMutableAttributedString(string: text)
            attrStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.highlightColor, range: NSMakeRange(0, openText.characters.count))
            this.viewController?.pullRequestsCountLabel?.attributedText = attrStr
            
            // Fill source
            this.source = results
            this.viewController?.tableView.reloadData()
            this.viewController?.refreshControl?.endRefreshing()
            this.isProcessing = false
            completion?()
            
        }) { [weak self] errorDescription in
            
            guard let this = self else { return }
            
            // Show error
            this.viewController?.errorHud(errorDescription)
            this.viewController?.refreshControl?.endRefreshing()
            this.isProcessing = false
            completion?()
        }
    }
}

