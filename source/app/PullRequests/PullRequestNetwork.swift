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

	func listPullRequestsOf(repoName: String, author: String, page: Int, completion: @escaping ([PullRequest]?, Error?) -> Void ){

		let listPullUrl = apiNetwork.urlListPullsJavaRepositories(with: author, in: repoName, at: page)

		self.network.request(listPullUrl, operation: .get, header: nil, params: nil) { (json, error) in

			if error != nil {
				completion(nil, error)
			} else {
				completion(PullRequest.generateMany(json: json!), nil)
			}
		}
	}
}
