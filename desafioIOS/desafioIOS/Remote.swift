//
//  Remote.swift
//  desafioIOS
//
//  Created by Vagner Oliveira on 7/19/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Remote {
	
	static var userList = [String:User]()
	
	static func fetchRepositories(fromPage page: UInt = 1,
	                              completed: @escaping (_ list: [Repository]?) -> Void) {
		guard let addr: URL = URL(string: "https://api.github.com/search/repositories") else {
			completed(nil)
			return
		}
		let parameters: Parameters = [
			"q": "language:Java",
			"sort": "stars",
			"page": page
		]
		var repList: [Repository] = []
		
		Alamofire.request(addr, method: .get, parameters: parameters).validate().responseJSON {
			response in
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				if let list = json["items"].array {
					for item in list {
						let repository = Repository.init(item)
						repList.append(repository)
					}
				}
			case .failure(let error):
				print(error)
				completed(nil)
			}
			completed(repList)
		}
	}
	
	static func retrievePullRequests(fromRepositoryNamed repositoryName: String,
	                                 completed: @escaping (_ list: [PullRequest]?) -> Void) {
		guard let addr: URL = URL(string: "https://api.github.com/repos/\(repositoryName)/pulls") else {
			completed(nil)
			return
		}
		var prList: [PullRequest] = []
		Alamofire.request(addr, method: .get).validate().responseJSON {
			response in
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				if let list = json.array {
					for item in list {
						let pullRequest = PullRequest.init(item)
						prList.append(pullRequest)
					}
				}
			case .failure(let error):
				print(error)
				completed(nil)
			}
			completed(prList)
		}
	}
	
	static func retrieveUser(withLogin login: String, completed: @escaping (_ user: User?) -> Void) {
		guard let addr: URL = URL(string: "https://api.github.com/users/\(login)") else {
			completed(nil)
			return
		}
		var newUser: User? = nil
		Alamofire.request(addr, method: .get).validate().responseJSON {
			response in
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				newUser = User.init(json)
			case .failure(let error):
				print(error)
				completed(nil)
			}
		}
		completed(newUser)
	}
}
