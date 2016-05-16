//
//  ReposDataManagerTests.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 14/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import Quick
import Nimble
@testable import Desafio_iOS

class DataManagerSpec: QuickSpec {
    
    override func spec() {
        describe ("GitHub API")  {
            
            var reposDataManager:ReposDataManager!
            var pullsDataManager:PullsDataManager!
            var status:GitHubAPIRequestStatus!
            var reposData:[Repo]?
            var pullsData:[Pulls]?
            var reqError:NSError?
            
            context ( "Make a request to the GitHubAPI for the Java Repositories" )  {
                beforeEach ()  {
                    reposDataManager = ReposDataManager.SharedInstance
                    pullsDataManager = PullsDataManager.SharedInstance
                }
                
                it ( "Returns json - Repos" )  {
                    // Request Async
                    reposDataManager.fetchReposForLanguage("Java", page: 1, callback: { (requestStatus, repos, error) in
                        status = requestStatus
                        reposData = repos
                        reqError = error
                    })
                    
                    expect(status).toEventually(equal(GitHubAPIRequestStatus.Success), timeout: 3)
                    expect(reposData).toEventuallyNot(beNil(), timeout: 3)
                    expect(reqError).toEventually(beNil(), timeout: 3)
                }
                
                it("Pulls", closure: {
                    let repo = reposData?.first
                    
                    pullsDataManager.fetchPullsForCreator(repo!.repoOwner.ownerName!, withName: repo!.repoName, callback: { (requestStatus, headerViewState, pulls, error) in
                        status = requestStatus
                        pullsData = pulls
                        reqError = error
                    })
                    
                    expect(status).toEventually(equal(GitHubAPIRequestStatus.Success), timeout: 3)
                    expect(pullsData).toEventuallyNot(beNil(), timeout: 3)
                    expect(reqError).toEventually(beNil(), timeout: 3)
                })
            }
        }
    }
}
