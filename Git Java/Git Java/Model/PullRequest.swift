//
//  PullRequest.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 27/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

struct PullRequest: Decodable {
    var idPullRequest: Int?
    var title: String?
    var body: String?
    var user: Owner?
    
    private enum CodingKeys: String, CodingKey {
        case idPullRequest = "id",
        title, body, user
    }
}
