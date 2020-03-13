//
//  Repositories.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 18/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
import RealmSwift

@testable import javahub

class RepositoriesTests: QuickSpec {

	let stubs = Stubs()

	override func setUp() {
		super.setUp()

		self.stubs.stubGetConnection(file: "listRepositoriesMock", host: "localhost", in: "/search/repositories")

		beforeSuite {
			 Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "RepositoryMock"
		}
	}

	override func spec() {

		describe("Test Repositories class") {

			var repositories: Repositories!
			var repositoriesView: RepositoriesViewController!

			context("Methods and Properties", closure: {

				beforeEach {

					// Run before each test

					let dic = self.instantiate()
					repositories = dic["Presenter"] as! Repositories
					repositoriesView = dic["View"] as! RepositoriesViewController

					let realm = try! Realm()
					try! realm.write {
						realm.deleteAll()
					}
				}

				// Puts test code here
				it("View not nil", closure: {

					expect(repositories.view).notTo(beNil())
				})

				it("router not nil", closure: {

					expect(repositories.router).notTo(beNil())
				})

				it("sizeList not nil", closure: {

					expect(repositories.sizeList).notTo(beNil())
				})

				it("network not nil", closure: {

					expect(repositories.network).toNot(beNil())
				})

				it("page must start at 1", closure: {

					expect(repositories.page).to(equal(1))
				})

				// Methods

				it("requestNetwork", closure: {

					waitUntil(action: { (done) in

						repositories.requestNetwork(finish: { (repos, error) in

							expect(repos!).toNot(beNil())
							expect(repos!.count).to(beGreaterThan(0))
							done()
						})
					})
				})

				it("requestLocalByNewData", closure: {

					repositoryMock()
					let result = repositories.requestLocalByNewData(with: "page > 0")
					expect(result.count).to(beGreaterThan(0))

				})

				it("buildCell must build and return a cell", closure: {

					repositories.repositories = [Repository()]
					let cell = repositories.buildCell(to: repositoriesView.tableView, at: IndexPath(row: 0, section: 0))
					expect(cell).toNot(beNil())
				})

				it("finishREquestNewData", closure: {

					repositories.page = 15
					var repos = [Repository]()
					repos.append(repositoryMockInstance())

					repositories.finishRequestNewData(repos: repos)

					expect(repos[0].page).to(equal(15))

					let realm = try! Realm()
					let results = realm.objects(Repository.self)

					expect(results.count).to(equal(1))
					expect(results[0].page).to(equal(15))
					print("Page 15: \(results[0].page)")

				})

				it("updateSizeListReloadView", closure: {

					var repos = [Repository]()
					repos.append(repositoryMockInstance())
					repos[0].page = 42

					repositories.updateSizeListReloadView(items: repos)

					expect(repositories.sizeList).to(equal(1))
					expect(repositories.repositories.count).to(equal(1))
					expect(repositories.repositories[0].page).to(equal(42))
				})

				it("requestLocalByNewData", closure: {

					var repos = [Repository]()
					repos.append(repositoryMockInstance())
					repos[0].page = 152

					let realm = try! Realm()
					try! realm.write {
						realm.add(repos)
					}

					let results = repositories.requestLocalByNewData(with: "page > 0")
					expect(results.count).to(equal(1))
					expect(results[0].page).to(equal(152))
				})
			})

		} // End Of Describe

		describe("Request Test") {

			var repositories: Repositories!

			context("Request", {

				beforeEach {

					let dic = self.instantiate()
					repositories = dic["Presenter"] as! Repositories
				}

				afterEach {

					let realm = try! Realm()
					try! realm.write {
						realm.deleteAll()
					}
				}

				it("requestNewDataExpandList Wiht Empty List", closure: {

					repositories.requestNewDataExpandList()

					expect(repositories.page).to(equal(1))
					expect(repositories.repositories.count).toEventually(beGreaterThan(0))

				})

				it("requestNewDataExpandList Wiht Fully List", closure: {

					repositories.repositories.append(Repository())
					repositories.requestNewDataExpandList()

					expect(repositories.page).to(beGreaterThan(1))
					expect(repositories.repositories.count).toEventually(beGreaterThan(0))

				})

				it("reNewDataResetList", closure: {

					repositories.reNewDataResetList()

					expect(repositories.page).to(equal(1))
					expect(repositories.repositories.count).to(equal(0))
				})
			})
		}

		describe("Navigation Test") {

			context("Origin RepositoiresView to PullRequestView", {

				var repositories: Repositories!
				var navController: RouterView!

				beforeEach {

					let dic = self.instantiate()
					repositories = dic["Presenter"] as! Repositories
					navController = dic["Navigation"] as! RouterView
				}

				it("To PullRequestView", closure: {

					repositories.repositories = [Repository()]
					repositories.showItem(at: 0)
					expect(navController.topViewController).toEventually(beAnInstanceOf(PullRequestsViewController.self))
				})
			})
		}

		func repositoryMock() {
			let repo = Repository()
			repo.identifier = "IDENTIFIER-MOCK"
			repo.name = "MOCK LOCA"
			repo.page = 1
			let realm = try! Realm()

			try! realm.write {

				realm.add(repo)
			}
		}

		func repositoryMockInstance() -> Repository{

			let repo = Repository()
			repo.identifier = "IDENTIFIER-MOCK-Instance"
			repo.name = "MOCK Instance"
			repo.page = 0

			return repo
		}
	}

	func instantiate() -> [String: Any] {

		let navControllerLocal = RouterView()
		navControllerLocal.presenter = Router(view: navControllerLocal)

		let viewLocal = RepositoriesViewController()
		let repositoriesLocal = Repositories(view: viewLocal, router: navControllerLocal.presenter!)
		viewLocal.presenter = repositoriesLocal

		return ["View": viewLocal, "Navigation": navControllerLocal, "Presenter": repositoriesLocal]
	}
}

