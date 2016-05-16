//
//  PullUser.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import Gloss

struct PullUser: Glossy {
    
    let userId: Int
    let userName: String?
    let userAvatar: NSURL?
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        guard
            let user_id: Int = "id" <~~ json,
            let user_name: String = "login" <~~ json,
            let user_avatar: String = "avatar_url" <~~ json
            else { return nil }
        
        userId = user_id
        userName = user_name
        userAvatar = NSURL(string: user_avatar)
        
    }
    
    //Não vai ser utilizado, mas fica como exemplo de serialização
    // MARK: - Serialization
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> userId,
            "login" ~~> userName,
            "avatar_url" ~~> userAvatar?.absoluteString
            ])
    }
    
}