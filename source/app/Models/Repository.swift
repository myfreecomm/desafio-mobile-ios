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

	@objc dynamic var identifier: String = ""
	@objc dynamic var name: String = ""
	@objc dynamic var detail: String = ""
	@objc dynamic var stars: Int = 0
	@objc dynamic var forks: Int = 0
	@objc dynamic var photo: String = ""
	@objc dynamic var author: String = ""

	@objc dynamic var page: Int = 0

	let pullrequests = List<PullRequest>()

	override class func primaryKey() -> String? {

		return "identifier"
	}

	static func generate(json: JSON) -> Repository {

		let repository = Repository()

		repository.identifier = String(json["id"].int!)
		repository.name = json["name"].string!
		repository.stars = json["stargazers_count"].int!
		repository.forks = json["forks_count"].int!
		repository.photo = json["owner"]["avatar_url"].string!
		repository.author = json["owner"]["login"].string!
		repository.detail = json["description"].string != nil ? json["description"].string! : ""

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
//	 

//	func list<T: Object>(query: String, entity: T.Type, property: String, asc: Bool) -> Results<T> {
//
//		return realm.objects(entity).filter(query).sorted(byKeyPath: property, ascending: asc)
//	}
}
