//
//  RepoOwner.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import Gloss

struct RepoOwner: Glossy {
    
    let ownerId: Int
    let ownerName: String?
    let ownerAvatar: NSURL?
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        guard
            let owner_id: Int = "id" <~~ json,
            let owner_name: String = "login" <~~ json,
            let owner_avatar: String = "avatar_url" <~~ json
        else { return nil }
        
        ownerId = owner_id
        ownerName = owner_name
        ownerAvatar = NSURL(string: owner_avatar)
        
    }
    
    //Não vai ser utilizado, mas fica como exemplo de serialização
    // MARK: - Serialization
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> ownerId,
            "login" ~~> ownerName,
            "avatar_url" ~~> ownerAvatar?.absoluteString
            ])
    }
    
}
