//
//  RepositoryService.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 25/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

class RepositoryService: RepositoryGettable {
    func getRepository(page: Int, completion: (([Repository], Int) -> Void)?) {
        let api = API()
        let url = String(format: "%@%i", API.urlRepositories, page)
        
        DispatchQueue.global(qos: .background).async {
            api.get(url: url, parameters: nil, success: { (statusCode, response) in
                do {
                    let decoder = JSONDecoder()
                    let result: RepositoryResult = try decoder.decode(RepositoryResult.self, from: response as! Data)
                    completion?(result.repositories, result.totalCount)
                    
                } catch {
                    completion?(self.returnRepositoryEmpty(), 0)
                }
                
                
            }, failure: { (statusCode, response) in
                completion?(self.returnRepositoryEmpty(), 0)
            })
        }
    }
    
    func returnRepositoryEmpty() -> [Repository] {
        let repositories: [Repository] = []
        return repositories
    }

}
