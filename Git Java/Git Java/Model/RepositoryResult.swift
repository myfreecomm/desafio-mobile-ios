//
//  RepositoryResult.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 25/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

struct RepositoryResult: Decodable {
    var totalCount: Int
    var incompleteResult: Bool
    var repositories: [Repository]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count",
        incompleteResult = "incomplete_results",
        repositories = "items"
    }
}
