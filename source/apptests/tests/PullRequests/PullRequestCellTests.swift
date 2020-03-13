//
//  PullRequestCellTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 20/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
import SwiftIconFont

@testable import javahub

class PullRequestCellTests: QuickSpec {

	var json: JSON!

	override func spec() {

		describe("Test PullRequestCell") {

			context("", closure: {

				var cell: PullRequestCell!

				beforeEach {

					// Run before each test
					self.json = Stubs.loadFile(with: "listPullRequestsMock", in: PullRequestCellTests.self)
					cell = Bundle.main.loadNibNamed(PullRequestCell.identifier, owner: nil, options: nil)?.first as! PullRequestCell
				}

				// Puts test code here
				it("SetupCell", closure: {

					let pullRequest: PullRequest = PullRequest.generate(json: self.json.array![0])

					cell.setupCell(data: pullRequest)

					expect(cell!.name.text).to(equal("Add an 'Override' annotaion"))
					expect(cell!.ownername.text).to(equal("zenuo"))
					expect(cell!.detail.text).to(equal("Add an annotation 'Override' to mothod 'AppClient.TcpLoggingClient#run'."))
					expect(cell!.date.text).to(equal("Criado em: 18/07/2018 09:15:13"))
					expect(cell!.photo).toEventuallyNot(beNil())
				})
			})
		}
	}
}
