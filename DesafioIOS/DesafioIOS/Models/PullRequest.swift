//
//  PullRequest.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 *  PullRequest
 *  @description    Local representation of Github's PullRequest
 */
public struct PullRequest {
    
    var id : Int = 0
    var title : String = ""
    var objectDescription : String = ""
    var state : String = ""
    var htmlUrl : String = ""
    var owner : Owner? = nil
    
    // Deserializer
    init(jsonData: [AnyHashable : Any]) {
        
        let json = JSON(jsonData)
        
        id = json["id"].intValue
        title = json["title"].stringValue
        objectDescription = json["description"].stringValue
        state = json["state"].stringValue
        htmlUrl = json["html_url"].stringValue
        
        if  let ownerData = json["user"].dictionary {
            owner = Owner(jsonData: ownerData)
        }
    }
}

