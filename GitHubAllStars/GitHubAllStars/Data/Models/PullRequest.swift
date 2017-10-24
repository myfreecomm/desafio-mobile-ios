//
//  PullRequest.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 23/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import UIKit
import ObjectMapper
class PullRequest: NSObject, Mappable {
    var id = 0
    var title = ""
    var body = ""
    var user = Owner()
    var created_at = Date()
    var html_url = ""
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
    }
}
