//
//  NetworkHandler.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol NetworkInterface{

	func request(
		_ address: String,
		operation: HTTPMethod,
		header: [String: String]?,
		params: [String: Any]?,
		completion: @escaping (JSON?, Error?) -> Void)
}

class Network: NSObject, NetworkInterface {

	func request(_ address: String, operation: HTTPMethod, header: [String: String]?, params: [String: Any]?, completion: @escaping (JSON?, Error?) -> Void) {

		UIApplication.shared.isNetworkActivityIndicatorVisible = true

		let urlInstance: URL = URL(string: address)!
		Alamofire.request(urlInstance, method: operation, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { (response) in

			UIApplication.shared.isNetworkActivityIndicatorVisible = false

			switch response.result {

			case .success(let value):

				completion(JSON(value), nil)

			case .failure(let error):

				completion(nil, error)
			}
		}
	}
}
