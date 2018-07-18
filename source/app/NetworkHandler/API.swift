//
//  API.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Foundation

protocol APIInterface{

	func urlListJavaRepositories(at page: Int) -> String
	func urlListPullsJavaRepositories(with nameAuthor: String, in repoName: String, at page: Int) -> String
}

struct API: APIInterface {

	private var systemEnviroment = EnviromentIdentifier()
	private var domainUrl: String!

	init() {

		switch systemEnviroment.enviroment {
		case "debug":

			domainUrl = "http://localhost/"

		case "release":

			domainUrl = "https://api.github.com/"

		default:
			fatalError("Domain url not defined. Check Environment.")
		}
	}

	func urlListJavaRepositories(at page: Int) -> String {

		return self.domainUrl + "search/repositories?q=language:Java&sort=stars&page=" + String(page)
	}

	func urlListPullsJavaRepositories(with nameAuthor: String, in repoName: String, at page: Int) -> String {

		return self.domainUrl + "repos/\(nameAuthor)/\(repoName)/pulls?page=\(page)"
	}
}
