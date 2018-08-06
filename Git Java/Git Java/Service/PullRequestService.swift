//
//  PullRequestService.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 27/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

class PullRequestService: PullRequestGettable {
    func getPullRequest(owner: String, repository: String, completion: (([PullRequest]) -> Void)?) {
        let api = API()
        let url = String(format: "https://api.github.com/repos/%@/%@/pulls", owner, repository)
        
        DispatchQueue.global(qos: .background).async {
            api.get(url: url, parameters: nil, success: { (statusCode, response) in
                do {
                    let decoder = JSONDecoder()
                    let result: [PullRequest] = try decoder.decode([PullRequest].self, from: response as! Data)
                    completion?(result)
                    
                } catch {
                    //completion?(self.returnRepositoryEmpty(), 0)
                }
                            
            }, failure: { (statusCode, response) in
                //completion?(self.returnRepositoryEmpty(), 0)
            })
        }
    }
    
    
}
