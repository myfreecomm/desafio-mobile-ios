//
//  PullRequestsViewModel.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

class PullRequestsViewModel {
    
    weak var viewController : PullRequestsViewController?
    
    var repository : Repository?
    
    fileprivate(set) var source = [PullRequest]()
    fileprivate(set) var isProcessing = false
    fileprivate(set) var openPullsCount = 0
    fileprivate(set) var closedPullsCount = 0
    
    fileprivate var service = PullRequestService()
    
    func refresh() {
        guard !isProcessing else { return }
        isProcessing = true
        // Re-fetch
        fetchData()
    }
    
    func fetchData(completion: (() -> Void)?=nil) {
        
        guard
            let safeRepository = repository,
            let safeOwner = safeRepository.owner
            else {
                viewController?.errorHud("Não foi possível carregar os dados desse repositório.")
                viewController?.refreshControl?.endRefreshing()
                completion?()
                return
        }
        
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
