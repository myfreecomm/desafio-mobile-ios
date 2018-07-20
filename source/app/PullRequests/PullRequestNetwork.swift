//
//  PullRequestNetwork.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 19/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Foundation

class PullRequestNetwork: NSObject {

	var apiNetwork: APIInterface = API()
	var network: NetworkInterface = Network()

	func listPullRequestsOf(repoName: String, author: String, page: Int, completion: @escaping ([PullRequest]) -> Void ){

		let listPullUrl = apiNetwork.urlListPullsJavaRepositories(with: author, in: repoName, at: page)

		self.network.request(listPullUrl, operation: .get, header: nil, params: nil) { (json) in

			completion(PullRequest.generateMany(json: json))
		}
	}
}
