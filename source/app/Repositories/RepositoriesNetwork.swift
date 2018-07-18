//
//  RepositoriesNetwork.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 18/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import UIKit

class RepositoriesNetwork: NSObject {

	var apiNetwork: APIInterface = API()
	var network: NetworkInterface = Network()

	func listRepositoriesJavaWith(page: Int, completion: @escaping ([Repository]) -> Void ){

		self.network.request(self.apiNetwork.urlListJavaRepositories(at: page), operation: .get, header: nil, params: nil) { (json) in

			completion(Repository.generateMany(json: json))
		}
	}
}
