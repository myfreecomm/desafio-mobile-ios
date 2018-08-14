//
//  User.swift
//  desafioIOS
//
//  Created by Vagner Oliveira on 7/19/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
	private(set) var login: String
	private(set) var avatarUrl: URL
	var userName: String?
	
	init(_ jsonObject: JSON) {
		login = jsonObject["login"].stringValue
		avatarUrl = URL(string: jsonObject["avatar_url"].stringValue)!
		if let name = jsonObject["name"].string {
			userName = name
		}
	}
}
