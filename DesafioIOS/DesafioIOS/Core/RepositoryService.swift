//
//  RepositoryService.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

public class RepositoryService : NSObject {
    
    public func load(page: Int=1, succeed: @escaping ([Repository]) -> Void, failed: @escaping (String) -> Void) {
        
        RestClient.repositories(page: page) { (didSucceed, data) in
            
            guard didSucceed else {
                if  let error = data as? Error {
                    failed(error.localizedDescription)
                }
                else {
                    failed("Ocorreu um erro desconhecido.")
                }
                return
            }
            
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
                failed("Não foi possível carregar os dados desta requisição")
            }
        }
    }
}
