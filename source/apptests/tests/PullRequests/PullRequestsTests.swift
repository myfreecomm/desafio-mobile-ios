//
//  PullRequestsTests.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 20/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
import RealmSwift

@testable import javahub

class PullRequestsTests: QuickSpec {

	let stubs: Stubs = Stubs()
	let localRepoJson: JSON = Stubs.loadFile(with: "listRepositoriesMock", in: PullRequestTests.self)

	override func setUp() {
		super.setUp()
		self.stubs.stubGetConnection(file: "listPullRequestsMock", host: "localhost", in: "/repos/iluwatar/java-design-patterns/pulls")

		beforeSuite {
			Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "RepositoryMock"
		}
	}

	override func spec() {
		
        describe("Tests PullRequests class") {

			var pullRequests: PullRequests!
			var pullRequestsView: PullRequestsViewController!

			context("", closure: {

				beforeEach {

					let dic = self.instantiate()
					pullRequests = dic["Presenter"] as! PullRequests
					pullRequestsView = dic["View"] as! PullRequestsViewController

					let realm = try! Realm()
					try! realm.write {
						realm.deleteAll()
					}
				}

                afterEach{

                     // Run after each test
                }

                // Puts test code here
				it("View not nil", closure: {

					expect(pullRequests.view).notTo(beNil())
				})

				it("router not nil", closure: {

					expect(pullRequests.router).notTo(beNil())
				})

				it("sizeList not nil", closure: {

					expect(pullRequests.sizeList).notTo(beNil())
				})

				it("network not nil", closure: {

					expect(pullRequests.network).toNot(beNil())
				})

				it("page must start at 1", closure: {

					expect(pullRequests.page).to(equal(1))
				})

				it("Init With Repository", closure: {

					expect(pullRequests.repository.pullrequests[0].page).to(equal(135))
				})

				it("requestNewDataExpandList", closure: {

					pullRequests.requestNewDataExpandList()
					expect(pullRequests.page).to(beGreaterThan(1))
					expect(pullRequests.repository.pullrequests.count).toEventually(beGreaterThan(1))
				})

				it("reNewDataResetList", closure: {

					let realm = try! Realm()
					try! realm.write {

						realm.add(pullRequests.repository)
					}

					pullRequests.reNewDataResetList()

					expect(pullRequests.page).to(equal(1))
					expect(pullRequests.repository.pullrequests.count).toEventually(beGreaterThan(1))

				})

				it("finishRequestNewData", closure: {

					var pulls = [PullRequest]()
					let pull = PullRequest()
					pull.title = "Title Test"
					pulls.append(pull)

					pullRequests.page = 230
					pullRequests.finishRequestNewData(pulls: pulls)

					let realm = try! Realm()
					let results = realm.objects(PullRequest.self)

					expect(results.count).to(equal(2))
					expect(results[0].page).to(equal(135))
					expect(results[1].page).to(equal(230))

				})

				it("updateSizeListReloadView", closure: {

					pullRequests.updateSizeListReloadView()
					expect(pullRequests.sizeList).to(equal(1))
					expect(pullRequests.repository.pullrequests.count).to(equal(1))
				})


				it("requestNetwork", closure: {

					waitUntil(action: { (done) in

						pullRequests.requestNetWork(finish: { (repos, error) in

							expect(repos!).toNot(beNil())
							expect(repos!.count).to(beGreaterThan(0))
							done()
						})
					})
				})

				it("repositories not empty after request", closure: {

					pullRequests.requestItens()
					expect(pullRequests.repository.pullrequests.count).toEventually(beGreaterThan(0))
				})

				it("buildCell must build and return a cell", closure: {

					let cell = pullRequests.buildCell(to: pullRequestsView.tableView, at: IndexPath(row: 0, section: 0))
					expect(cell).toNot(beNil())
				})
            })
        }
	}

	func mockRepository() -> Repository {

		let repo = Repository()
		let pullRequest = PullRequest()

		repo.name = "java-design-patterns"
		repo.author = "iluwatar"

		pullRequest.page = 135

		let realm = try! Realm()
		try! realm.write {

			repo.pullrequests.append(pullRequest)

		}

		return repo
	}

	func instantiate() -> [String: Any] {

		let navigationView = RouterView()
		navigationView.presenter = Router(view: navigationView)

		let view = PullRequestsViewController()
		let presenter = PullRequests(view: view, router: navigationView.presenter!, repository: mockRepository())
		view.presenter = presenter

		return ["View": view, "Navigation": navigationView, "Presenter": presenter]
	}
}
