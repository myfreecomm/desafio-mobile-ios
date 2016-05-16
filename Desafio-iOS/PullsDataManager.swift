//
//  PullsDataManager.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

typealias PullResponse = (GitHubAPIRequestStatus, HeaderViewState, [Pulls]?, NSError?) -> Void

class PullsDataManager: NSObject {

    static let SharedInstance: PullsDataManager = {
        
        var manager = PullsDataManager()
        
        return manager
        
    }()
    
    func fetchPullsForCreator(creator:String, withName name:String, callback:PullResponse) {
        
        Alamofire.request(GitHubAPI.AllPulls(creator: creator, name: name))
            .responseJSON {
                response in
                
                var requestStatus: GitHubAPIRequestStatus = .Fetching
                var headerState:HeaderViewState = .Default
                var error:NSError?
                
                switch response.result {
                case .Success:
                    
                    if let JSONData = response.result.value as? NSDictionary {
                        
                        let message:String = JSONData["message"] as! String
                        
                        if message.hasPrefix(kAPIRequestStatusMessageRateLimit) {
                            requestStatus = .RateLimit
                        } else {
                            requestStatus = .Other
                        }
                        
                        headerState = .Info
                        
                        error = NSError(domain: "API Message", code: 1, userInfo: [NSLocalizedDescriptionKey : kAPIRequestStatusMessageRateLimit])
                        
                        callback(requestStatus,headerState,nil,error)
                        
                        return
                    }
                    
                    if let JSONData = response.result.value as? [JSON] {
                        
                        guard let pulls = Pulls.modelsFromJSONArray(JSONData) else
                        {
                            print("Issue deserializing model array")
                            
                            requestStatus = .Other
                            headerState = .Info
                            error = NSError(domain: "Deserializing Error", code: 2, userInfo: [NSLocalizedDescriptionKey :   "Ops!, aconteceu algum problema, tente novamente em alguns segundos."])
                            
                            callback(requestStatus,headerState,nil,error)
                            
                            return
                        }
                        
                        requestStatus = .Success
                        headerState = .Default
                        
                        callback(requestStatus, headerState, pulls, nil)
                    }
                    
                case .Failure:
                    
                    requestStatus = .Error
                    headerState = .Info
                    error = response.result.error
                    
                    callback(requestStatus,headerState,nil,error)
                }
        }

    }
}
