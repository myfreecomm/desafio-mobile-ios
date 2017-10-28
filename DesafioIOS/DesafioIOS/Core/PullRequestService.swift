//
//  PullRequestService.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

public class PullRequestService : NSObject {
    
    public func load(owner: String, repository: String, succeed: @escaping ([PullRequest]) -> Void, failed: @escaping (String) -> Void) {
        
        RestClient.pullRequests(owner: owner, repository: repository) { (didSucceed, data) in
            
            guard didSucceed else {
                if  let error = data as? Error {
                    failed(error.localizedDescription)
                }
                else {
                    failed("Ocorreu um erro desconhecido.")
                }
                return
            }
            
            if  let json = data as? [[String:Any]] {
                var results = [PullRequest]()
                for item in json {
                    let object = PullRequest(jsonData: item)
                    results.append(object)
                }
                succeed(results)
            }
            else {
                failed("Não foi possível carregar os dados desta requisição")
            }
        }
    }
}
