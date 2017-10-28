//
//  Owner.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Owner {
    
    var id : String = ""
    var name : String = ""
    var username : String = ""
    var picture : String = ""
    
    init(jsonData: Data) {
        
        let json = JSON(data: jsonData)
        
        id = json["id"].stringValue
        name = json["login"].stringValue
        username = json["login"].stringValue
        picture = json["avatar_url"].stringValue
    }
}

