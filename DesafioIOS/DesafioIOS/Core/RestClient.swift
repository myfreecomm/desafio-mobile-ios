//
//  RestClient.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation
import Alamofire

class RestClient : NSObject {
    
    typealias Callback = (Bool, Any?) -> Void
    
    class func sendRequest(url: String, completion: @escaping Callback) {
        print("Rest Client calling --> \(url)")
        Alamofire
            .request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("RestClient -> call succeed")
                    completion(true, response.result.value)
                case .failure(let error):
                    print("RestClient -> call failed")
                    print(error)
                    completion(false, error)
                }
        }
    }
    
    // MARK: - Repositories
    class func repositories(page: Int=1, completion: @escaping Callback) {
        let urlWithParams = String(format: "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=%i", page)
        RestClient.sendRequest(url: urlWithParams, completion: completion)
    }
    
    // MARK: - Pull Requests
    class func pullRequests(owner: String, repository: String, completion: @escaping Callback) {
        let urlWithParams = String(format: "https://api.github.com/repos/%@/%@/pulls", owner, repository)
        RestClient.sendRequest(url: urlWithParams, completion: completion)
    }
}

