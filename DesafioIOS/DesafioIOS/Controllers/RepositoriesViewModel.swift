//
//  RepositoriesViewModel.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

public class RepositoriesViewModel {
    
    weak var viewController: RepositoriesViewController?
    
    fileprivate(set) public var source = [Repository]()
    fileprivate(set) public var page = 1
    fileprivate(set) public var isProcessing = false
    
    public var service = RepositoryService()
    
    public func refresh() {
        
        guard !isProcessing else { return }
        isProcessing = true
        
        // Reset
        page = 1
        
        // Re-fetch
        fetchData() { [weak self] in
            self?.viewController?.refreshControl?.endRefreshing()
        }
    }
    
    public func fetchData(completion: (() -> Void)?=nil) {
        
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
}

// MARK: - Infinite Scrolling
extension RepositoriesViewModel {
    
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

