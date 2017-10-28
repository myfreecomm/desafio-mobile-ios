//
//  Repository.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Repository {
    
    var id : Int = 0
    var name : String = ""
    var fullName : String = ""
    var objectDescription : String = ""
    var forks : Int = 0
    var stars : Int = 0
    var owner : Owner? = nil
    
    init(jsonData: Data) {
        
        let json = JSON(data: jsonData)
        
        id = json["id"].intValue
        name = json["name"].stringValue
        fullName = json["full_name"].stringValue
        objectDescription = json["description"].stringValue
        forks = json["forks_count"].intValue
        stars = json["stargazers_count"].intValue
        
        if  let ownerData = try? json["owner"].rawData() {
            owner = Owner(jsonData: ownerData)
        }
    }
}


