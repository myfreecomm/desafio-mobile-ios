//
//  PullRequestsNetworkTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 20/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
@testable import javahub

class PullRequestNetworkTests: QuickSpec {

	let stubs = Stubs()

	override func setUp() {
		super.setUp()
		self.stubs.stubGetConnection(file: "listPullRequestsMock", host: "localhost", in: "/repos/iluwatar/java-design-patterns/pulls")
	}

	override func spec() {
		
        describe("Teste PullRequestNetwork") {

			afterSuite {
				self.stubs.clearStubs()
			}

			context("Request Repositories", closure: {

				var pullNetwork: PullRequestNetwork!

				beforeEach {

					pullNetwork = PullRequestNetwork()
				}

				it("Check apiNetwork not be nil", closure:{

					expect(pullNetwork.apiNetwork).notTo(beNil())
				})

				it("Check network not be nil", closure:{

					expect(pullNetwork.network).notTo(beNil())
				})

				// Puts test code here
				it(" Method Get", closure: {

					var result: [PullRequest] = [PullRequest]()

					pullNetwork.listPullRequestsOf(repoName: "java-design-patterns", author: "iluwatar", page: 1, completion: { (pullrequests, error) in

						result = pullrequests!
					})

					expect(result).toEventuallyNot(beNil())
					expect(result.count).toEventually(beGreaterThan(0))
				})
			})
        }
	}
}
