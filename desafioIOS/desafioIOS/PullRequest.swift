//
//  PullRequest.swift
//  desafioIOS
//
//  Created by Vagner Oliveira on 7/19/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import Foundation
import SwiftyJSON

class PullRequest {
	
	private(set) var title: String
	private(set) var prDate: Date
	private(set) var prBody: String
	private(set) var prURL: URL
	private var prOwner: User
	var owner: User {
		get {
			if prOwner.userName == nil {
				if let u = Remote.userList[prOwner.login] {
					prOwner = u
				} else {
					Remote.retrieveUser(withLogin: prOwner.login) {
						(user: User?) in
						if let res = user {
							Remote.userList[self.prOwner.login] = res
							self.prOwner = res
						} else {
							self.prOwner.userName = ""
						}
					}
				}
			}
			return prOwner
		}
		set {
			prOwner = newValue
		}
	}
	
	
	init(_ jsonObject: JSON) {
		title = jsonObject["title"].stringValue
		prBody = jsonObject["body"].stringValue
		prURL = URL(string: jsonObject["html_url"].stringValue)!
		let ds = DateFormatter()
		ds.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		prDate = ds.date(from: jsonObject["updated_at"].stringValue)!
		prOwner = User.init(jsonObject["user"])
	}
}
