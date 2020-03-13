//
//  RepositoriesViewTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 18/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
import RealmSwift

@testable import javahub

class RepositoriesViewTests: QuickSpec {

	let stubs = Stubs()

	override func setUp() {
		super.setUp()
		self.stubs.stubGetConnection(file: "listRepositoriesMock", host: "localhost", in: "/search/repositories")

		beforeSuite {
			Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "RepositoryMock"
		}
	}

	override func spec() {
		
        describe("Test RepositoriesView") {

			afterSuite {

				self.stubs.clearStubs()
			}

			context("", closure: {

				var repositoriesView: RepositoriesViewController!

				beforeEach {

					let dic = self.instantiate()
					repositoriesView = dic["View"] as! RepositoriesViewController

					let realm = try! Realm()
					try! realm.write {
						realm.deleteAll()
					}
				}

				it("Check Title", closure: {

					let titleTest: String = "Title Test"
					repositoriesView.setTitleView(title: titleTest)
					expect(repositoriesView.navigationItem.title).to(equal(titleTest))
				})

				it("Check TableView", closure: {

					expect(repositoriesView.tableView).notTo(beNil())
				})

				it("Check RefreshControl not nil", closure: {

					repositoriesView.setupRefreshControl()
					expect(repositoriesView.refreshControl!).notTo(beNil())
				})

				it("Check Presenter not nil", closure: {

					expect(repositoriesView.presenter).notTo(beNil())
				})

				it("Check UpdateData", closure: {

					repositoriesView.updateData()
					expect(repositoriesView.tableView.numberOfRows(inSection: 0)).toEventually(beGreaterThan(0))
					expect(repositoriesView.tableView.numberOfRows(inSection: 0)).toEventually(equal(30))

				})

				it("Check setupInfinityScroll()", closure: {

					repositoriesView.setupInfinityScroll()

					expect(repositoriesView.tableView.infiniteScrollIndicatorStyle).to(equal(.gray))
					expect(repositoriesView.tableView.infiniteScrollIndicatorMargin).to(equal(40))
					expect(repositoriesView.tableView.infiniteScrollTriggerOffset).to(equal(500))

				})

				it("Check register cell", closure: {

					repositoriesView.registerCell()
					let registeredNibs = repositoriesView.tableView.value(forKey: "_nibMap") as? [String:UINib]
					let key =  Array(registeredNibs!.keys)[0]
					expect(key).to(equal("RepositoryCell"))
				})
            })
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
