//
//  PullRequestService.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

/**
 *  RepositoryService
 *  @description    Local Micro-service responsible only for PR's requests
 */
public class PullRequestService {
    
    /**
     *  load(owner:repository:succeed:failed:)
     *  @description        Load Github repositories
     *  @param owner        Repository owner
     *  @param repository   Repository slug
     *  @param succeed      Callback fired when request succeed
     *  @param failed       Callback fired when request failed
     */
    public func load(owner: String, repository: String, succeed: @escaping ([PullRequest]) -> Void, failed: @escaping (String) -> Void) {
        
        // Send Request
        RestClient.pullRequests(owner: owner, repository: repository) { (didSucceed, data) in
            
            // Catch errors
            guard didSucceed else {
                if  let error = data as? Error {
                    failed(error.localizedDescription)
                }
                else {
                    failed("Error.Unknown".localized)
                }
                return
            }
            
            // Unleash data
            if  let json = data as? [[String:Any]] {
                var results = [PullRequest]()
                for item in json {
                    let object = PullRequest(jsonData: item)
                    results.append(object)
                }
                succeed(results)
            }
            else {
                failed("Error.FailedRequest".localized)
            }
        }
    }
}
