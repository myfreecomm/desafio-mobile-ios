//
//  Repository.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

class Repository : NSObject {
    
    var id : Int = 0
    var name : String = ""
    var fullName : String = ""
    var objectDescription : String = ""
    var forks : Int = 0
    var stars : Int = 0
    var owner : Owner? = nil
    
    init(data: [String:Any]) {
        
        self.id = (data["id"] as? Int).unwrapOrElse(0)
        self.name = (data["name"] as? String).unwrapOrElse("")
        self.fullName = (data["full_name"] as? String).unwrapOrElse("")
        self.objectDescription = (data["description"] as? String).unwrapOrElse("")
        self.forks = (data["forks_count"] as? Int).unwrapOrElse(0)
        self.stars = (data["stargazers_count"] as? Int).unwrapOrElse(0)
        
        // Owner
        if  let owner = data["owner"] as? [String:Any] {
            self.owner = Owner(data: owner)
        }
    }
}


