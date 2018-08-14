//
//  Repository.swift
//  desafioIOS
//
//  Created by Vagner Oliveira on 7/19/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import Foundation
import SwiftyJSON

class Repository {
	
	private(set) var name: String
	private(set) var description: String
	private(set) var numberOfStars: UInt
	private(set) var numberOfForks: UInt
	private var repOwner: User
	var owner: User {
		get {
			if repOwner.userName == nil {
				if let u = Remote.userList[repOwner.login] {
					repOwner = u
				} else {
					Remote.retrieveUser(withLogin: repOwner.login) {
						(user: User?) in
						if let res = user {
							Remote.userList[self.repOwner.login] = res
							self.repOwner = res
						} else {
							self.repOwner.userName = ""
						}
					}
				}
			}
			return repOwner
		}
		set {
			repOwner = newValue
		}
	}
	
	var repositoryFullName: String {
		get {
			return String("\(owner.login)/\(name)")
		}
	}
	
	init(_ jsonObject: JSON) {
		name = jsonObject["name"].stringValue
		description = jsonObject["description"].stringValue
		numberOfForks = jsonObject["forks_count"].uIntValue
		numberOfStars = jsonObject["stargazers_count"].uIntValue
		repOwner = User.init(jsonObject["owner"])
	}
}
