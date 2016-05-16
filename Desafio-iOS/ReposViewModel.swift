//
//  ReposViewModel.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import Foundation

class ReposViewModel: NSObject {

    var reloadTableViewCallback: (() -> Void)!
    
    var reposArray:[Repo] = []
    var currentPage:Int = 1
    var searchLanguage:String = "Java"
    var requestStatus:GitHubAPIRequestStatus = .Success
    var requestError:NSError?
    
    init(reloadTableViewCallback : () -> Void) {
        
        super.init()
        self.reloadTableViewCallback = reloadTableViewCallback
        retrieveData()
    }
    
    func retrieveData(){

        requestStatus = .Fetching
        
        ReposDataManager.SharedInstance.fetchReposForLanguage(searchLanguage, page: currentPage) { (requestStatus, repos, error) in
            
            self.requestStatus = requestStatus
            self.requestError = error
            if repos != nil {
                self.reposArray.appendContentsOf(repos!)
            }
        
            RepoCD.save(self.reposArray)
            
            self.reloadTableViewCallback()
        }
    }
    
    
}
