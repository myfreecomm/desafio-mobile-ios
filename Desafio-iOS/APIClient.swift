//
//  APIClient.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

//Retorno da API com alguma menssagem de "erro": - Validation Faied, Only the first 1000 search results are available, API rate limit exceeded for, etc.
//https://developer.github.com/v3/#client-errors

import Alamofire

let kAPIRequestStatusMessageFinished:String = "Only the first 1000 search results are available"
let kAPIRequestStatusMessageRateLimit:String = "API rate limit exceeded for"

enum GitHubAPIRequestStatus:String {
    case Fetching
        ,Success   //Page request OK
        ,FetchLimit = "Only the first 1000 search results are available"
        ,RateLimit = "API rate limit exceeded"
        ,Other
        ,Error
}

enum GitHubAPI: URLRequestConvertible {
    
    //https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1
    //https://api.github.com/repos/vsouza/awesome-ios/pulls
    
    static let baseURLString = "https://api.github.com/"
    static let perPage = 1
    
    case AllRepos(language:String, page:Int)
    case AllPulls(creator:String, name:String)
    
    // MARK: URLRequestConvertible
    var URLRequest: NSMutableURLRequest {
        let result: (path: String, parameters: [String: AnyObject]?) = {
            switch self {
            case .AllRepos(let language, let page):
                return ("search/repositories", ["q": language, "sort":"stars" ,"page": page])
            case .AllPulls(let creator, let name):
                return ("repos/\(creator)/\(name)/pulls", nil)
            }
        }()
        
        let URL = NSURL(string: GitHubAPI.baseURLString)!
        let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        let encoding = Alamofire.ParameterEncoding.URL
        
        
        switch self {
        case .AllRepos:
            return encoding.encode(URLRequest, parameters: result.parameters).0
        case .AllPulls:
            return encoding.encode(URLRequest, parameters: nil).0
        }
    }
}

