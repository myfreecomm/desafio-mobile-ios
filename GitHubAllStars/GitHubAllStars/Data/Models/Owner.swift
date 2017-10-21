//
//  Owner.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 21/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import UIKit
import ObjectMapper
class Owner: NSObject, Mappable {
    var login       = ""
    var avatarURL   = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        login <- map["login"]
        avatarURL <- map["avatar_url"]
    }
}
