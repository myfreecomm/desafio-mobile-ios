//
//  Repository.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 21/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
class Repository: Object, Mappable  {
    @objc dynamic var repositoryId: Int32 = 0
    @objc dynamic var name: String = ""
    @objc dynamic var fullName: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var forksCount: Int32 = 0
    @objc dynamic var stargazersCount: Int32 = 0
    @objc dynamic var owner: Owner?
    
    override class func primaryKey() -> String? {
        return "repositoryId"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        repositoryId <- map["id"]
        name <- map["name"]
        fullName <- map["full_name"]
        desc <- map["description"]
        forksCount <- map["forks_count"]
        stargazersCount <- map["stargazers_count"]
        owner <- map["owner"]
    }
}


