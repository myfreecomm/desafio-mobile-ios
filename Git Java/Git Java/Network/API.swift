//
//  API.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 25/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation
import Alamofire

class API {
    static let baseUrl = "https://api.github.com/"
    static let language = "Java"
    static let urlRepositories = String(format: "%@search/repositories?q=language:%@&sort=stars&page=", baseUrl, language)
    let httpClient: HTTPClient = HTTPClient()
    
    func get(url: URLConvertible, parameters: Parameters?, success: @escaping (Int, Any) -> Void,
             failure: @escaping (Int, Any) -> Void) {
        httpClient.get(url: url, parameters: parameters).responseJSON { response in
            self.handleResponse(response: response, success: success, failure: failure)
        }
    }
    
    func handleResponse(response: DataResponse<Any>, success: (Int, Any) -> Void,
                        failure: (Int, Any) -> Void ) {
        let statusCode: Int! = response.response?.statusCode
        
        switch response.result {
        case .success :
            if response.result.value != nil {
                success(statusCode, response.data ?? "")
            } else {
                failure(statusCode, response)
            }
        case .failure :
            if let statusCode = response.response?.statusCode {
                failure(statusCode, response)
            } else {
                // Network issues
                failure(400, response)
            }
        }
    }
}

