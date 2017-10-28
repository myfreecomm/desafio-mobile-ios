//
//  PullRequestService.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

class PullRequestService : NSObject {
    
    func load(owner: String, repository: String, succeed: @escaping ([PullRequest]) -> Void, failed: @escaping (String) -> Void) {
        RestClient.pullRequests(owner: owner, repository: repository) { (didSucceed, data) in
            if  didSucceed {
                if  let json = data as? [[String:Any]] {
                    var results = [PullRequest]()
                    for item in json {
                        let object = PullRequest(data: item)
                        results.append(object)
                    }
                    succeed(results)
                }
                else {
                    failed("Não foi possível carregar os dados desta requisição")
                }
            }
            else {
                if  let error = data as? Error {
                    failed(error.localizedDescription)
                }
                else {
                    failed("Ocorreu um erro desconhecido.")
                }
            }
        }
    }
}
