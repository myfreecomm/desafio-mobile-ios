//
//  Repository.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 18/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Repository: Object {

	@objc dynamic var name: String = ""
	@objc dynamic var detail: String = ""
	@objc dynamic var stars: Int = 0
	@objc dynamic var forks: Int = 0
	@objc dynamic var photo: String = ""
	@objc dynamic var author: String = ""

	static func generate(json: JSON) -> Repository {

		let repository = Repository()

		repository.name = json["name"].string!
		repository.stars = json["stargazers_count"].int!
		repository.forks = json["forks_count"].int!
		repository.photo = json["owner"]["avatar_url"].string!
		repository.author = json["owner"]["login"].string!

		if let text = json["description"].string {

			repository.detail = text
		} else {

			repository.detail = ""
	    }

		return repository
	}

	static func generateMany(json: JSON) -> [Repository] {

		var repositorys = [Repository]()
		guard let items = json["items"].array else {
			return [Repository]()
		}

		for repo in items {

			repositorys.append(Repository.generate(json: repo))
		}

		return repositorys
	}
}
