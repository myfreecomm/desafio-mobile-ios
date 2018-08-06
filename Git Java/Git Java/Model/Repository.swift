//
//  Repository.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 25/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    var idRepository: Int?
    var name: String?
    var description: String?
    var forkCount: Int?
    var starCount: Int?
    var owner: Owner?
    
    private enum CodingKeys: String, CodingKey {
        case idRepository = "id",
        name, description, owner,
        forkCount = "forks_count",
        starCount = "stargazers_count"
    }
}
