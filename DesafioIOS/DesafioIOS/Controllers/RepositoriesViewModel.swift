//
//  RepositoriesViewModel.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

/**
 *  RepositoriesViewModel
 *  @description    Repository's View Model
 */
class RepositoriesViewModel {
    
    /**
     * View Controller weak reference
     */
    weak var viewController: RepositoriesViewController?
    
    /**
     * Repository Micro Service
     */
    fileprivate var service = RepositoryService()
    
    /**
     * Repository source
     */
    fileprivate(set) var source = [Repository]()
    
    /**
     * Current page
     */
    fileprivate(set) var page = 1
    
    /**
     * Processing state
     */
    fileprivate(set) var isProcessing = false
    
    
    // MARK: - 🔐 Common Methods
    
    
    /**
     *  refresh()
     *  @description    Toggles processing state & reset the data
     */
    func refresh() {
        
        guard !isProcessing else { return }
        isProcessing = true
        
        // Reset
        page = 1
        
        // Re-fetch
        fetchData() { [weak self] in
            self?.viewController?.refreshControl?.endRefreshing()
        }
    }
    
    /**
     *  fetchData(completion:)
     *  @description        Fires Repository micro service request
     *  @param completion   Callback fired when request is completed
     */
    func fetchData(completion: (() -> Void)?=nil) {
        
        // Send request
        service.load(page: self.page, succeed: { [weak self] results in
            
            guard let this = self else { return }
            
            if  this.page == 1 {
                this.source = []
            }
            this.source.append(contentsOf: results)
            this.viewController?.tableView.reloadData()
            this.isProcessing = false
            completion?()
            
        }) { [weak self] errorDescription in
            
            guard let this = self else { return }
            
            // Show error
            this.viewController?.errorHud(errorDescription)
            this.viewController?.refreshControl?.endRefreshing()
            this.isProcessing = false
        }
    }
    
    // MARK: - 🌀 Infinite Scrolling
    
    /**
     *  triggerInfiniteScrolling(completion:)
     *  @description        Toggles processing state & loads next page
     *  @param completion   Callback fired when request is completed
     */
    func triggerInfiniteScrolling(completion: (()->Void)?=nil) {
        
        guard !isProcessing else {
            completion?()
            return
        }
        
        isProcessing = true
        viewController?.infiniteScrollingView?.alpha = 1
        page += 1
        fetchData() { [weak self] in
            self?.viewController?.infiniteScrollingView?.alpha = 0
            completion?()
        }
    }
}

