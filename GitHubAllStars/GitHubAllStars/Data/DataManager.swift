//
//  DataManager.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 21/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import UIKit
class DataManager: NSObject {
    private override init(){}
    static let sharedInstance: DataManager = DataManager()
    
    func getStarsRepositories(language: String, page: Int, callback:@escaping (_ error: Bool, _ message: String, _ repositories: [Repository]?) -> Void) {
        WebManager.sharedInstance.starsRequest(language: "", page: 1) { (error, message, repositoriesResponse) in
            if !error {
                if let repositories = repositoriesResponse {
                    callback(false, "DataManager Get Repositories List - Successful", repositories)
                } else {
                    callback(true, ">> DataManager getStarsRepositories - Error!", [Repository]())
                }
            } else {
                callback(true, message, repositoriesResponse)
            }
        }
    }
}
