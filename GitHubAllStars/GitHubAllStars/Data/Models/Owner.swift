//
//  Owner.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 21/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
class Owner: Object, Mappable {
    @objc dynamic var login: String = ""
    @objc dynamic var avatarURL: String = ""
    @objc dynamic var name: String = ""
    
    override class func primaryKey() -> String? {
        return "login"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        login <- map["login"]
        avatarURL <- map["avatar_url"]
        name <- map["name"]
    }
}

