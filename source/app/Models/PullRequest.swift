//
//  PullRequest.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 18/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class PullRequest: Object {

	@objc dynamic var author: String = JsonPropertys.empty.content
	@objc dynamic var photo: String = JsonPropertys.empty.content
	@objc dynamic var title: String = JsonPropertys.empty.content
	@objc dynamic var createAt: String = JsonPropertys.empty.content
	@objc dynamic var link: String = JsonPropertys.empty.content
	@objc dynamic var body: String = JsonPropertys.empty.content

	@objc dynamic var repoAuthor: String = JsonPropertys.empty.content
	@objc dynamic var repoName: String = JsonPropertys.empty.content
	@objc dynamic var page: Int = 0

	static func generate(json: JSON) -> PullRequest {

		let pullRequest = PullRequest()

		pullRequest.author = json[JsonPropertys.user.content][JsonPropertys.login.content].string!
		pullRequest.photo = json[JsonPropertys.user.content][JsonPropertys.avatar.content].string!
		pullRequest.title = json[JsonPropertys.title.content].string!
		pullRequest.createAt = PullRequest.dateFormatter(stringDate: json[JsonPropertys.created.content].string!)
		pullRequest.link = json[JsonPropertys.html.content].string!
		pullRequest.body = json[JsonPropertys.body.content].string != nil ? json[JsonPropertys.body.content].string! : JsonPropertys.empty.content

		return pullRequest
	}

	static func generateMany(json: JSON) -> [PullRequest] {

		var pullRequests =  [PullRequest]()
		guard let items = json.array else {
			return [PullRequest]()
		}

		for pull in items {

			pullRequests.append(PullRequest.generate(json: pull))
		}

		return pullRequests
	}

	static func dateFormatter (stringDate: String) -> String {

		let fomatter = DateFormatter()
		fomatter.dateFormat = JsonPropertys.yyyyMMddTHHmmssZ.content
		let date = fomatter.date(from: stringDate)!

		fomatter.dateFormat = JsonPropertys.ddMMyyyyHHmmss.content
		fomatter.timeZone = TimeZone(secondsFromGMT: 0)
		return fomatter.string(from: date)
	}
}
