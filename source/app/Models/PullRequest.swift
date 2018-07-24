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

	@objc dynamic var author: String = ""
	@objc dynamic var photo: String = ""
	@objc dynamic var title: String = ""
	@objc dynamic var createAt: String = ""
	@objc dynamic var link: String = ""
	@objc dynamic var body: String = ""

	@objc dynamic var repoAuthor: String = ""
	@objc dynamic var repoName: String = ""
	@objc dynamic var page: Int = 0

	static func generate(json: JSON) -> PullRequest {

		let pullRequest = PullRequest()

		pullRequest.author = json["user"]["login"].string!
		pullRequest.photo = json["user"]["avatar_url"].string!
		pullRequest.title = json["title"].string!
		pullRequest.createAt = PullRequest.dateFormatter(stringDate: json["created_at"].string!)
		pullRequest.link = json["html_url"].string!
		pullRequest.body = json["body"].string != nil ? json["body"].string! : ""

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
		fomatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		let date = fomatter.date(from: stringDate)!

		fomatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
		fomatter.timeZone = TimeZone(secondsFromGMT: 0)
		return fomatter.string(from: date)
	}
}
