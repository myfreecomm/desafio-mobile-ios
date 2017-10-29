//
//  RestClient.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation
import Alamofire

/**
 *  RestClient
 *  @description   The RESTful interface
 */
class RestClient : NSObject {
    
    /**
     * Internal typealias for completion
     */
    typealias Callback = (Bool, Any?) -> Void
    
    /**
     *  sendRequest(url:completion:)
     *  @description        Sends the request to API
     *  @param url          Given URL to fetch the request
     *  @param completion   Callback fired when request is completed
     */
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
                    print("RestClient Error -> \(error.localizedDescription)")
                    completion(false, error)
                }
        }
    }
    
    // MARK: - 👨🏻‍💻 Repositories
    
    /**
     *  repositories(page:completion:)
     *  @description        Fetch Java most popular repositories in Github
     *  @param page         Page to be fetched (default is 1)
     *  @param completion   Callback fired when request is completed
     */
    class func repositories(page: Int=1, completion: @escaping Callback) {
        let urlWithParams = String(format: "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=%i", page)
        RestClient.sendRequest(url: urlWithParams, completion: completion)
    }
    
    // MARK: - 👨🏻‍💻 Pull Requests
    
    /**
     *  pullRequests(owner:repository:completion:)
     *  @description        Fetch Available pull requests for a given repository
     *  @param owner        Repository owner
     *  @param repository   Repository slug
     *  @param completion   Callback fired when request is completed
     */
    class func pullRequests(owner: String, repository: String, completion: @escaping Callback) {
        let urlWithParams = String(format: "https://api.github.com/repos/%@/%@/pulls", owner, repository)
        RestClient.sendRequest(url: urlWithParams, completion: completion)
    }
}

