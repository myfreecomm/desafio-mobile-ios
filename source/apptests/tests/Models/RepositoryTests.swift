//
//  RepositoryTests.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 18/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
@testable import javahub

class RepositoryTests: QuickSpec {

	var json: JSON!

	override func spec() {
		
        describe("Test Repository Model") {

			context("Repository Init", closure: {

				beforeEach {
					self.json = Stubs.loadFile(with: "listRepositoriesMock", in: RepositoryTests.self)
				}

                // Puts test code here

				it("Instantiate One", closure: {

					let repository: Repository = Repository.generate(json: self.json["items"][0])

					expect(repository.name).to(equal("java-design-patterns"))
					expect(repository.detail).to(equal("Design patterns implemented in Java"))
					expect(repository.stars).to(equal(35936))
					expect(repository.forks).to(equal(11611))
					expect(repository.photo).to(equal("https://avatars1.githubusercontent.com/u/582346?v=4"))
					expect(repository.author).to(equal("USER MOCK LOCAL"))
				})

				it ("Instantiate Many", closure: {

					let repositorys: [Repository] = Repository.generateMany(json: self.json)
					expect(repositorys.count).to(beGreaterThan(0))

					let repository : Repository = repositorys[0]
					expect(repository.name).to(equal("java-design-patterns"))
					expect(repository.detail).to(equal("Design patterns implemented in Java"))
					expect(repository.stars).to(equal(35936))
					expect(repository.forks).to(equal(11611))
					expect(repository.photo).to(equal("https://avatars1.githubusercontent.com/u/582346?v=4"))
					expect(repository.author).to(equal("USER MOCK LOCAL"))
				})
            })
        }
	}
}
