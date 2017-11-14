//
//  Repository.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 *  Repository
 *  @description    Local representation of Github's Repository
 */
public struct Repository {
    
    var id : Int = 0
    var name : String = ""
    var fullName : String = ""
    var objectDescription : String = ""
    var forks : Int = 0
    var stars : Int = 0
    var owner : Owner? = nil
    
    // Deserializer
    init(jsonData: [AnyHashable: Any]) {
        
        let json = JSON(jsonData)
        
        id = json["id"].intValue
        name = json["name"].stringValue
        fullName = json["full_name"].stringValue
        objectDescription = json["description"].stringValue
        forks = json["forks_count"].intValue
        stars = json["stargazers_count"].intValue
        
        if  let ownerData = json["owner"].dictionary {
            owner = Owner(jsonData: ownerData)
        }
    }
}


