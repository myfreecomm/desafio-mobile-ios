//
//  RepoDataManager.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

typealias RepoResponse = (GitHubAPIRequestStatus, [Repo]?, NSError?) -> Void

public class ReposDataManager: NSObject {

    static let SharedInstance: ReposDataManager = {
        
        var manager = ReposDataManager()
        
        return manager
        
    }()
    
    
    func fetchReposForLanguage(language:String, page:Int, callback:RepoResponse) {
        
        Alamofire.request(GitHubAPI.AllRepos(language: "language:\(language)", page: page))
            .responseJSON {
                response in
                
                var requestStatus: GitHubAPIRequestStatus = .Fetching
                
                switch response.result {
                case .Success:
                    
                    if let JSONData = response.result.value as? NSDictionary {
                        
                        guard let items:[JSON] = JSONData["items"] as? [JSON] else {
                            
                            let message:String = JSONData["message"] as! String
                            
                            if message.hasPrefix(kAPIRequestStatusMessageFinished) {
                                requestStatus = .FetchLimit
                                
                            } else if message.hasPrefix(kAPIRequestStatusMessageRateLimit) {
                                requestStatus = .RateLimit
                            } else {
                                requestStatus = .Other
                            }
                            
                            callback(requestStatus,nil, nil)
                            
                            return
                        }
                        
                        guard let repos = Repo.modelsFromJSONArray(items) else {
                            print("Issue deserializing model array")
                            
                            requestStatus = .Other
                            callback(requestStatus,nil, nil)
                            
                            return
                        }
                        
                        
                        requestStatus = .Success
                        callback(requestStatus,repos, nil)
                    }
                case .Failure:
                    
                    requestStatus = .Error
                    callback(requestStatus, nil, response.result.error)
                }
        }
    }
    
}
