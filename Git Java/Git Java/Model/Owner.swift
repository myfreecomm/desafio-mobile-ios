//
//  Owner.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 25/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    var idOwner: Int?
    var login: String?
    var avatarUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case idOwner = "id",
        login,
        avatarUrl = "avatar_url"
    }
}
