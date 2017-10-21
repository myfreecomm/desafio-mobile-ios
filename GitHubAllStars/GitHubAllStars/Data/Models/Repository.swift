//
//  Repository.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 21/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import UIKit
import ObjectMapper
class Repository: NSObject, Mappable  {
    var id              = 0
    var name            = ""
    var fullName        = ""
    var desc            = ""
    var forksCount      = 0
    var stargazersCount = 0
    var owner           = Owner()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        fullName <- map["full_name"]
        desc <- map["description"]
        forksCount <- map["forks_count"]
        stargazersCount <- map["stargazers_count"]
        owner <- map["owner"]
    }
}

