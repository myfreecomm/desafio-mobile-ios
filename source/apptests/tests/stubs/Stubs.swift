//
//  Stubs.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Foundation
import SwiftyJSON
import OHHTTPStubs

class Stubs {

	func stubGetConnection(file: String, host: String, in path: String) {

		stub(condition: isMethodGET() && isHost(host) && isPath(path)) { _ in

			let stub = OHPathForFile(file + ".json", type(of: self))
			guard let productsStub = stub else { preconditionFailure(file + ".json not found!") }

			print("\nLoad Stub in \(file) \n")
			return OHHTTPStubsResponse(fileAtPath: productsStub, statusCode: 200, headers: [ "ContentType": "application/json" ])
		}

		OHHTTPStubs.setEnabled(true)
	}

	func clearStubs(){

		OHHTTPStubs.removeAllStubs()
	}


	static func loadFile(with name: String, in bundleClass: AnyClass) -> JSON {

		let path = Bundle(for: bundleClass).path(forResource: name, ofType: "json")

		do {
			let data = try Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)

			return try JSON(data: data)

		} catch {

			fatalError("Error parse data to json: listRepositoriesMock from json file")
		}
	}
}

