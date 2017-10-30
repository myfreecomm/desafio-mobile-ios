//
//  PullRequest.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 23/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
class PullRequest: Object, Mappable {
    @objc dynamic var id: Int32 = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var user: Owner?
    @objc dynamic var repository: Repository?
    @objc dynamic var created_at: String = ""
    @objc dynamic var html_url: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
        user <- map["user"]
        created_at <- map["created_at"]
        html_url <- map["html_url"]
        repository <- map["base.repo"]
    }
}
