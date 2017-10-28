//
//  PullRequest.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

class PullRequest : NSObject {
    
    var id : Int = 0
    var title : String = ""
    var objectDescription : String = ""
    var state : String = ""
    var htmlUrl : String = ""
    var owner : Owner? = nil
    
    init(data: [String:Any]) {
        
        self.id = (data["id"] as? Int).unwrapOrElse(0)
        self.title = (data["title"] as? String).unwrapOrElse("")
        self.objectDescription = (data["body"] as? String).unwrapOrElse("")
        self.state = (data["state"] as? String).unwrapOrElse("")
        self.htmlUrl = (data["html_url"] as? String).unwrapOrElse("")
        
        // Owner
        if  let owner = data["user"] as? [String:Any] {
            self.owner = Owner(data: owner)
        }
    }
}

