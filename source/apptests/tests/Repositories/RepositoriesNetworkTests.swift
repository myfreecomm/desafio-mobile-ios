//
//  RepositoriesNetworkTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 19/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON

@testable import javahub

class RepositoriesNetworkTests: QuickSpec {

	let stubs = Stubs()

	override func setUp() {
		super.setUp()
		self.stubs.stubGetConnection(file: "listRepositoriesMock", host: "localhost", in: "/search/repositories")
	}

	override func spec() {
		
        describe("Test RepositoriesNetwork") {

			afterSuite {

				self.stubs.clearStubs()
			}

			context("Request Repositories", closure: {

				var repoNetwork: RepositoriesNetwork!

				beforeEach {

					repoNetwork = RepositoriesNetwork()
				}

				it("Check apiNetwork not be nil", closure:{

					expect(repoNetwork.apiNetwork).notTo(beNil())
				})

				it("Check network not be nil", closure:{

					expect(repoNetwork.network).notTo(beNil())
				})

                // Puts test code here
				it(" Method Get", closure: {

					var result: [Repository] = [Repository]()

					repoNetwork.listRepositoriesJavaWith(page: 1) { (repositories, error) in

						result = repositories!
					}

					expect(result).toEventuallyNot(beNil())
					expect(result.count).toEventually(beGreaterThan(0))
				})
            })
        }
	}
}
