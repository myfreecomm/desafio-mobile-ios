//
//  LocalDataPersistenceTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 25/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
import RealmSwift

@testable import javahub

class LocalDataPersistenceTests: QuickSpec {

	override func setUp() {
		super.setUp()

		beforeSuite {
			Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "RepositoryMock"
		}
	}

	override func spec() {
		
        describe("Tests LocalDataPersistenceTests") {

			var persistence: LocalDataPersistence!

			context("", closure: {

				beforeEach {
					persistence = LocalDataPersistence()

					let realm = try! Realm()
					try! realm.write {
						realm.deleteAll()
					}
                }

                afterEach{
					let realm = try! Realm()
					try! realm.write {
						realm.deleteAll()
					}
                }

				it("SaveItens", closure: {

					let repository = Repository()
					repository.identifier = "121512"
					persistence.saveItens(items: [repository], reNew: false)

					let realm = try!  Realm()
					let results = realm.objects(Repository.self)

					expect(results.count).to(equal(1))
					expect(results[0].identifier).to(equal("121512"))
				})

				it ("updateRepo - clear: TRUE", closure: {

					let repository = Repository()
					repository.identifier = "121512"
					let pull = PullRequest()
					pull.page = 151

					let realm = try! Realm()
					try! realm.write { repository.pullrequests.append(pull) }
					try! realm.write { realm.add(repository) }

					let resultA = realm.objects(Repository.self)
					expect(resultA[0].pullrequests.count).to(equal(1))

					persistence.updateRepo(newPulls: nil, into: repository, clear: true)

					let resultB = realm.objects(Repository.self)
					expect(resultB[0].pullrequests.count).to(equal(0))
				})

				it ("updateRepo - clear: FALSE", closure: {

					let repository = Repository()
					repository.identifier = "121512"
					let pull = PullRequest()
					pull.page = 151

					expect(repository.pullrequests.count).to(equal(0))

					persistence.updateRepo(newPulls: [pull], into: repository, clear: false)

					let realm = try! Realm()
					let resultA = realm.objects(Repository.self)
					expect(resultA[0].pullrequests.count).to(equal(1))

				})

				it("ClearLocalStorage", closure: {

					var repos = [Repository]()

					for i in 0 ... 10{

						let repo = Repository()
						repo.identifier = String(i)
						repos.append(repo)
					}

					let realm = try! Realm()
					try! realm.write { realm.add(repos)	}

					let resultA = realm.objects(Repository.self)
					expect(resultA.count).to(equal(11))

					persistence.clearLocalStorage()

					let resultB = realm.objects(Repository.self)
					expect(resultB.count).to(equal(0))
				})

				it("List", closure: {

					var repos = [Repository]()

					for i in 0 ... 10{

						let repo = Repository()
						repo.identifier = String(i)
						repo.page = i + 1
						repo.stars = ((i * 3) + (i * i)) * 325
						repos.append(repo)
					}

					let realm = try! Realm()
					try! realm.write { realm.add(repos)	}

					let results = persistence.list(query: "page > 0", entity: Repository.self, property: "stars", isAcendent: false)
					expect(results.count).to(equal(11))
					expect(results[10].stars).to(beLessThan(results[0].stars))
					expect(results.first?.stars).to(equal(42250))
				})
            })
        }
	}
}


















