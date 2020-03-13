//
//  PullRequestsViewControllerTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 20/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import SwiftyJSON

@testable import javahub

class PullRequestsViewControllerTests: QuickSpec {

	let stubs: Stubs = Stubs()

	override func setUp() {
		super.setUp()
		self.stubs.stubGetConnection(file: "listPullRequestsMock", host: "localhost", in: "/repos/iluwatar/java-design-patterns/pulls")

		beforeSuite {
			Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "RepositoryMock"
		}
	}

	override func spec() {
		
        describe("Tests for PullRequestsViewController") {

			context("", closure: {

				var pullRequests: PullRequests!
				var pullRequestsView: PullRequestsViewController!

				beforeEach {

					let realm = try! Realm()
					try! realm.write {
						realm.deleteAll()
					}

					let dic = self.instantiate()
					pullRequests = dic["Presenter"] as! PullRequests
					pullRequestsView = dic["View"] as! PullRequestsViewController

					try! realm.write {
						realm.add(pullRequests.repository)
					}
				}

				it("Check Title", closure: {

					let titleTest: String = "Title Test"
					pullRequestsView.setTitleView(title: titleTest)
					expect(pullRequestsView.navigationItem.title).to(equal(titleTest))
				})

				it("Check TableView", closure: {

					expect(pullRequestsView.tableView).notTo(beNil())
				})

				it("Check RefreshControl not nil", closure: {

					pullRequestsView.setupRefreshControl()
					expect(pullRequestsView.refreshControl!).notTo(beNil())
				})

				it("Check Presenter not nil", closure: {

					expect(pullRequestsView.presenter).notTo(beNil())
				})

				it("Check UpdateData", closure: {

					pullRequestsView.updateData()
					expect(pullRequestsView.tableView.numberOfRows(inSection: 0)).toEventually(beGreaterThan(0))
					expect(pullRequestsView.tableView.numberOfRows(inSection: 0)).toEventually(equal(9))

				})

				it("Check setupInfinityScroll()", closure: {

					pullRequestsView.setupInfinityScroll()

					expect(pullRequestsView.tableView.infiniteScrollIndicatorStyle).to(equal(.gray))
					expect(pullRequestsView.tableView.infiniteScrollIndicatorMargin).to(equal(40))
					expect(pullRequestsView.tableView.infiniteScrollTriggerOffset).to(equal(500))

				})

				it("Check register cell", closure: {

					pullRequestsView.registerCell()
					let registeredNibs = pullRequestsView.tableView.value(forKey: "_nibMap") as? [String:UINib]
					let key =  Array(registeredNibs!.keys)[0]
					expect(key).to(equal("PullRequestCell"))
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
