//
//  PullsViewModel.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import Foundation

class PullsViewModel: NSObject {

    var reloadTableViewCallback: (() -> Void)!
    
    var pullsArray:[Pulls] = []
    var headerViewState:HeaderViewState = .Default
    var requestStatus:GitHubAPIRequestStatus = .Success
    var requestError:NSError?
    
    var repoCreator:String?
    var repoName:String?
    var repoIssues:Int?
    
    init(reloadTableViewCallback : () -> Void) {
        
        super.init()
        self.reloadTableViewCallback = reloadTableViewCallback
    }
    
    func retrieveData(){
        
        requestStatus = .Fetching

        PullsDataManager.SharedInstance.fetchPullsForCreator(repoCreator!, withName: repoName!) { (requestStatus, headerViewState, pulls, error) in
            
            self.requestStatus = requestStatus
            self.requestError = error
            self.headerViewState = headerViewState
            if pulls != nil {
                self.pullsArray = pulls!
            }
            
            PullsCD.save(self.pullsArray)
            
            self.reloadTableViewCallback()
        }
    }
}
