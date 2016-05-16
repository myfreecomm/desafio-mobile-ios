//
//  Pulls.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import Gloss

struct Pulls: Glossy {
  
    let pullId: Int
    let pullTitle: String
    let pullBody: String
    let pullDate: NSDate?
    let pullUrl: NSURL
    let pullUser:PullUser
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        guard
            let pull_id: Int = "id" <~~ json,
            let pull_title: String = "title" <~~ json,
            let pull_body: String = "body" <~~ json,
            let pull_url:NSURL = "html_url" <~~ json,
            let pull_user: PullUser = "user" <~~ json
            else { return nil }
        
        pullId = pull_id
        pullTitle = pull_title
        pullBody = pull_body
        pullUrl = pull_url
        pullDate = Decoder.decodeDateUsingCurrentLocale("updated_at")(json)
        pullUser = pull_user
    }
    
    //Não vai ser utilizado, mas fica como exemplo de serialização
    // MARK: - Serialization
    
    func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> pullId,
            "title" ~~> pullTitle,
            "body" ~~> pullBody,
            "html_url" ~~> pullUrl.absoluteString,
            Encoder.encodeDateISO8601("updated_at")(pullDate),
            "user" ~~> pullUser
            ])
    }
}

extension Decoder {
    
    static func decodeDateUsingCurrentLocale(key: String) -> JSON -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    
        return Decoder.decodeDate(key, dateFormatter: dateFormatter)
    }
    
}


