//
//  DataManager.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 21/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
class DataManager: NSObject {
    private override init(){}
    static let sharedInstance: DataManager = DataManager()
    
    func getStarsRepositories(language: String, page: Int, callback:@escaping (_ error: Bool, _ message: String, _ repositories: [Repository]?) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            WebManager.sharedInstance.starsRequest(language: "", page: page) { (error, message, repositoriesResponse) in
                if !error {
                    if let repositories = repositoriesResponse {
                        callback(false, "DataManager Get Repositories List - Successful", repositories)
                        
                        let realm = try! Realm()
                        try! realm.write {
                            realm.add(repositories, update: true)
                        }
                    } else {
                        callback(true, ">> DataManager getStarsRepositories - Error!", [Repository]())
                    }
                } else {
                    let repositoriesResultSet = self.getOfflineRepositoriesList()
                    if repositoriesResultSet.count > 0 {
                        var repositories: [Repository] = [Repository]()
                        repositories.append(contentsOf: repositoriesResultSet)
                        callback(false, "No Internet Access - Showing offline data", repositories)
                    } else {
                        callback(true, "Failure to communicate", [Repository]())
                    }
                }
            }
        } else {
            let repositoriesResultSet = getOfflineRepositoriesList()
            if repositoriesResultSet.count > 0 {
                var repositories: [Repository] = [Repository]()
                repositories.append(contentsOf: repositoriesResultSet)
                callback(false, "No Internet Access - Showing offline data", repositories)
            } else {
                callback(true, "Check your Internet access and try again", [Repository]())
            }
        }
    }
    
    func getPullRequest(repository: String, callback:@escaping (_ error: Bool, _ message: String, _ stadimus: [PullRequest]?) -> Void) {
        if NetworkReachabilityManager()!.isReachable {
            WebManager.sharedInstance.pullRequests(repository: repository) { (error, message, pullRequests) in
                if !error {
                    if let prs = pullRequests {
                        callback(false, "DataManager Get Pull Requests - Successful", prs)
                        
                        let realm = try! Realm()
                        try! realm.write {
                            realm.add(prs, update: true)
                        }
                    } else {
                        callback(true, "DataManager Get Pull Requests - Error", pullRequests)
                    }
                } else {
                    let pullRequestsResultSet = self.getOfflinePullRequestsList(repository: repository)
                    if pullRequestsResultSet.count > 0 {
                        var pullRequests: [PullRequest] = [PullRequest]()
                        pullRequests.append(contentsOf: pullRequestsResultSet)
                        callback(false, "No Internet Access - Showing offline data", pullRequests)
                    } else {
                        callback(true, "Check your Internet access and try again", [PullRequest]())
                    }                }
            }
        } else {
            let pullRequestsResultSet = getOfflinePullRequestsList(repository: repository)
            if pullRequestsResultSet.count > 0 {
                var pullRequests: [PullRequest] = [PullRequest]()
                pullRequests.append(contentsOf: pullRequestsResultSet)
                callback(false, "No Internet Access - Showing offline data", pullRequests)
            } else {
                callback(true, "Check your Internet access and try again", [PullRequest]())
            }
        }
    }
    
    func getOfflineRepositoriesList() -> Results<Repository> {
        let realm = try! Realm()
        let repositories = realm.objects(Repository.self)
        return repositories
    }
    
    func getOfflinePullRequestsList(repository: String) -> Results<PullRequest> {
        let realm = try! Realm()
        let prs = realm.objects(PullRequest.self).filter("repository.fullName = '\(repository)'")
        return prs
    }
}
