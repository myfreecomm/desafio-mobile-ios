//
//  APIInterfaceTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
@testable import javahub

class APIInterfaceTests: QuickSpec {

	override func spec() {

		describe("Test APIInterface") {

			var apiInterface: APIInterface!
			context("Request", closure: {

				beforeEach {

					// Run before each test
					apiInterface = API()
				}

				// Puts test code here

				it("Get Url list repositories page 1", closure: {

					expect(apiInterface.urlListJavaRepositories(at: 1)).to(equal("http://localhost/search/repositories?q=language:Java&sort=stars&page=1"))
				})

				it("Get Url list pullrequests page 1", closure: {

					expect(apiInterface.urlListPullsJavaRepositories(with: "author", in: "repository", at: 1)).to(equal("http://localhost/repos/author/repository/pulls?page=1"))
				})
			})
		}
	}
}
