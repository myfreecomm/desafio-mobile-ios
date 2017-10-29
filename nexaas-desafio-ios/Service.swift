//
//  Service.swift
//  nexaas-desafio-ios
//
//  Created by Rogerio Cervasio on 27/10/17.
//  Copyright © 2017 ACME. All rights reserved.
//

import Alamofire
import ObjectMapper

public class Service: BaseService {
    
    static let shared = Service()
    
    public override init() {
        super.init()
        
        self.baseAddress = "https://api.github.com/"
        self.baseVersion = ""
        
        self.startReachabilityMonitoring()
    }
    
    func responseMessage(_ object:AnyObject?) -> String {
        return (object?["message"] != nil ? (object?["message"] as? String)! : "")
    }
    
    public func getRepositories(_ q: String, _ sort: String, _ page: Int, completion: ((_ finished: Bool, _ repositories: Repositories?) -> Void)? = nil) -> Request {
        
        let parameters = ["q": q, "sort": sort, "page": page] as [String : Any]
        
        return self.apiRequest(.get, address: self.baseAPI! + "search/repositories", parameters: parameters) { (_ finished, _ response) in
            
            var repositories: Repositories?
            
            if finished {
                
                repositories = Mapper<Repositories>().map(JSONObject: response)
            }
            
            completion?(finished, repositories)
        }
    }
    
    public func getRepositoryPulls(owner: String, repo: String, page: Int, completion: ((_ finished: Bool, _ pull: [Pull]?, _ message: String?) -> Void)? = nil) -> Request {
        //  GET /repos/:owner/:repo/pulls
        /*
         Parameters
         Name	Type	Description
         state	string	Either open, closed, or all to filter by state. Default: open
         head	string	Filter pulls by head user and branch name in the format of user:ref-name. Example: github:new-script-format.
         base	string	Filter pulls by base branch name. Example: gh-pages.
         sort	string	What to sort results by. Can be either created, updated, popularity (comment count) or long-running (age, filtering by pulls updated in the last month). Default: created
         direction	string	The direction of the sort. Can be either asc or desc. Default: desc when sort is created or sort is not specified, otherwise asc.
         */
        
        let parameters = ["page": page] as [String : Any]
        
        return self.apiRequest(.get, address: self.baseAPI! + "repos/" + owner + "/" + repo + "/pulls", parameters: parameters) { (_ finished, _ response) in
            
            var pull: [Pull]?
            
            var message: String?
            
            if finished {
                
                message = self.responseMessage(response)
                
                pull = Mapper<Pull>().mapArray(JSONObject: response)
            }
            
            completion?(finished, pull, message)
        }
    }
}

