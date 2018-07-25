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

	@objc dynamic var identifier: String = JsonPropertys.empty.content
	@objc dynamic var name: String = JsonPropertys.empty.content
	@objc dynamic var detail: String = JsonPropertys.empty.content
	@objc dynamic var stars: Int = 0
	@objc dynamic var forks: Int = 0
	@objc dynamic var photo: String = JsonPropertys.empty.content
	@objc dynamic var author: String = JsonPropertys.empty.content

	@objc dynamic var page: Int = 0

	let pullrequests = List<PullRequest>()

	override class func primaryKey() -> String? {

		return JsonPropertys.labelIdentifier.content
	}

	static func generate(json: JSON) -> Repository {

		let repository = Repository()

		repository.identifier = String(json[JsonPropertys.identifier.content].int!)
		repository.name = json[JsonPropertys.name.content].string!
		repository.stars = json[JsonPropertys.stars.content].int!
		repository.forks = json[JsonPropertys.fork.content].int!
		repository.photo = json[JsonPropertys.owner.content][JsonPropertys.avatar.content].string!
		repository.author = json[JsonPropertys.owner.content][JsonPropertys.login.content].string!
		repository.detail = json[JsonPropertys.description.content].string != nil ? json[JsonPropertys.description.content].string! : JsonPropertys.empty.content

		return repository
	}

	static func generateMany(json: JSON) -> [Repository] {

		var repositorys = [Repository]()
		guard let items = json[JsonPropertys.items.content].array else {
			return [Repository]()
		}

		for repo in items {

			repositorys.append(Repository.generate(json: repo))
		}

		return repositorys
	}
}
