//
//  RepositoriesViewModel.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

public class RepositoriesViewModel {
    
    public weak var viewController: RepositoriesViewController?
    
    fileprivate(set) public var source = [Repository]()
    fileprivate(set) public var page = 1
    fileprivate(set) public var isProcessing = false
    
    public var service = RepositoryService()
    
    public func refresh() {
        
        guard !isProcessing else { return }
        
        isProcessing = true
        page = 1
        
        // Re-fetch
        fetchData() { [weak self] in
            self?.viewController?.refreshControl?.endRefreshing()
        }
    }
    
    public func fetchData(completion: (() -> Void)?=nil) {
        
        service.load(page: self.page, succeed: { [weak self] results in
            
            if  let this = self {
                if  this.page == 1 {
                    this.source = []
                }
                this.source.append(contentsOf: results)
                this.viewController?.tableView.reloadData()
                this.isProcessing = false
                completion?()
            }
            
        }) { [weak self] errorDescription in
            guard let this = self else { return }
            // Show error
            this.viewController?.errorHud(errorDescription)
            this.viewController?.refreshControl?.endRefreshing()
            this.isProcessing = false
        }
    }
}

// MARK: - Infinite Scrolling
extension RepositoriesViewModel {
    
    func triggerInfiniteScrolling(completion: (()->Void)?=nil) {
        if !self.isProcessing {
            self.isProcessing = true
            self.viewController?.infiniteScrollingView?.alpha = 1
            self.page += 1
            self.fetchData() {
                [weak self] in
                if  let this = self {
                    this.viewController?.infiniteScrollingView?.alpha = 0
                    completion?()
                }
            }
        }
        else {
            completion?()
        }
    }
}
