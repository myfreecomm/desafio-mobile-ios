//
//  RepositoryService.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

/**
 *  RepositoryService
 *  @description    Local Micro-service responsible only for repository requests
 */
public class RepositoryService {
    
    /**
     *  load(page:succeed:failed:)
     *  @description    Load Github repositories
     *  @param page     Page to be fetched (default is 1)
     *  @param succeed  Callback fired when request succeed
     *  @param failed   Callback fired when request failed
     */
    public func load(page: Int=1, succeed: @escaping ([Repository]) -> Void, failed: @escaping (String) -> Void) {
        
        // Send request
        RestClient.repositories(page: page) { (didSucceed, data) in
            
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
            if  let json = data as? [String:Any],
                let items = json["items"] as? [[String:Any]] {
                var results = [Repository]()
                for item in items {
                    let object = Repository(jsonData: item)
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
