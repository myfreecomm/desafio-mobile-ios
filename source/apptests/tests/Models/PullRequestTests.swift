//
//  PullRequestTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 18/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
@testable import javahub

class PullRequestTests: QuickSpec {

	var json: JSON!

	override func spec() {

        describe("Test PullRequest Model") {

			context("PullRequest Init", closure: {

				beforeEach {
					self.json = Stubs.loadFile(with: "listPullRequestsMock", in: PullRequestTests.self)
				}

				// Puts test code here

				it("Instantiate One", closure: {

					let pullRequest: PullRequest = PullRequest.generate(json: self.json[0])

					expect(pullRequest.title).to(equal("Add an 'Override' annotaion"))
					expect(pullRequest.photo).to(equal("https://avatars1.githubusercontent.com/u/22318999?v=4"))
					expect(pullRequest.author).to(equal("zenuo"))
					expect(pullRequest.createAt).to(equal("18/07/2018 09:15:13"))
					expect(pullRequest.link).to(equal("https://github.com/iluwatar/java-design-patterns/pull/774"))
					expect(pullRequest.body).to(equal("Add an annotation 'Override' to mothod 'AppClient.TcpLoggingClient#run'."))
				})

				it ("Instantiate Many", closure: {

					let pullRequests: [PullRequest] = PullRequest.generateMany(json: self.json)
					expect(pullRequests.count).to(beGreaterThan(0))

					let pullRequest : PullRequest = pullRequests[0]
					expect(pullRequest.title).to(equal("Add an 'Override' annotaion"))
					expect(pullRequest.photo).to(equal("https://avatars1.githubusercontent.com/u/22318999?v=4"))
					expect(pullRequest.author).to(equal("zenuo"))
					expect(pullRequest.createAt).to(equal("18/07/2018 09:15:13"))
					expect(pullRequest.link).to(equal("https://github.com/iluwatar/java-design-patterns/pull/774"))
					expect(pullRequest.body).to(equal("Add an annotation 'Override' to mothod 'AppClient.TcpLoggingClient#run'."))
				})

				it ("Convert date format", closure: {

					let finalDate = PullRequest.dateFormatter(stringDate: "2018-07-18T09:15:13Z")

					expect(finalDate).to(equal("18/07/2018 09:15:13"))

				})
			})
        }
	}
}
