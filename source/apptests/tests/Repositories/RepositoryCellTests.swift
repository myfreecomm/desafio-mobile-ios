//
//  RepositoryCellTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 19/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
import SwiftIconFont

@testable import javahub

class RepositoryCellTests: QuickSpec {

	var json: JSON!

	override func spec() {
		
        describe("Test RepositoryCell") {

			context("", closure: {

				var cell: RepositoryCell!

				beforeEach {

                    // Run before each test
					self.json = Stubs.loadFile(with: "listRepositoriesMock", in: RepositoryCellTests.self)
					cell = Bundle.main.loadNibNamed(RepositoryCell.identifier, owner: nil, options: nil)?.first as! RepositoryCell
                }

                // Puts test code here
				it("SetupCell", closure: {

					let repository: Repository = Repository.generate(json: self.json["items"][0])
					var iconFork = String.fontAwesomeIcon("codefork")!
					var iconStars = String.fontAwesomeIcon("star")!
					iconFork.append(" 11611")
					iconStars.append(" 35936")

					cell.setupCell(data: repository)

					expect(cell!.name.text).to(equal("java-design-patterns"))
					expect(cell!.ownername.text).to(equal("iluwatar"))
					expect(cell!.forks.text).to(equal(iconFork))
					expect(cell!.starts.text).to(equal(iconStars))
					expect(cell!.detail.text).to(equal("Design patterns implemented in Java"))

					expect(cell!.photo).toEventuallyNot(beNil())

				})

				it("buildIconText", closure: {

					var iconFork = String.fontAwesomeIcon("codefork")!
					iconFork.append(" text mock")

					let uilabel: UILabel = UILabel()

					cell.buildIconText(label: uilabel, fontSize: 10.0, text: "text mock", fontName: "codefork")
					expect(uilabel.text!).to(equal(iconFork))
				})
            })
        }
	}
}
