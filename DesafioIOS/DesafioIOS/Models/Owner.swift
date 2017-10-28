//
//  Owner.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

class Owner : NSObject {
    
    var id : String = ""
    var name : String = ""
    var username : String = ""
    var picture : String = ""
    
    init(data: [String:Any]) {
        
        self.id = (data["id"] as? String).unwrapOrElse("")
        self.name = (data["login"] as? String).unwrapOrElse("")
        self.username = (data["login"] as? String).unwrapOrElse("")
        self.picture = (data["avatar_url"] as? String).unwrapOrElse("")
    }
}

