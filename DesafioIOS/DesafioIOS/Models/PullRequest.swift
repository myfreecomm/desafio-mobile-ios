//
//  PullRequest.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PullRequest {
    
    var id : Int = 0
    var title : String = ""
    var objectDescription : String = ""
    var state : String = ""
    var htmlUrl : String = ""
    var owner : Owner? = nil
    
    init(jsonData: Data) {
        
        let json = JSON(data: jsonData)
        
        id = json["id"].intValue
        title = json["title"].stringValue
        objectDescription = json["description"].stringValue
        state = json["state"].stringValue
        htmlUrl = json["html_url"].stringValue
        
        if  let ownerData = try? json["owner"].rawData() {
            owner = Owner(jsonData: ownerData)
        }
    }
}

