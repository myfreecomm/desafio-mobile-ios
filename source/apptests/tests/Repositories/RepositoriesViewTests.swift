//
//  RepositoriesViewTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 18/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
@testable import javahub

class RepositoriesViewTests: QuickSpec {

	let stubs = Stubs()

	override func setUp() {
		super.setUp()
		self.stubs.stubGetConnection(file: "listRepositoriesMock", host: "localhost", in: "/search/repositories")
	}

	override func spec() {
		
        describe("Test RepositoriesView") {

			afterSuite {

				self.stubs.clearStubs()
			}

			context("", closure: {

				var repositoriesView: RepositoriesViewController!
				var navController: RouterView!

				beforeEach {

					// Run before each test
					navController = RouterView()
					navController.loadViewIfNeeded()
					navController.presenter = Router(view: navController)
					navController.presenter!.goTo(destiny: .repositories, pushForward: nil)

					repositoriesView = navController.visibleViewController as! RepositoriesViewController
					repositoriesView.loadViewIfNeeded()

					let delegate = UIApplication.shared.delegate as! AppDelegate
					delegate.window = UIWindow(frame: UIScreen.main.bounds)
					delegate.window?.rootViewController = navController
					delegate.window?.makeKeyAndVisible()
				}

                afterEach{

				// Run after each test
                }

                // Puts test code here
				it("Check Title", closure: {

					expect(repositoriesView.navigationItem.title).to(equal("JavaHub"))
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

				// Methods

				it("Check RequestNewData", closure: {

					repositoriesView.requestNewData()
					expect(repositoriesView.tableView.numberOfRows(inSection: 0)).toEventually(beGreaterThan(0))
					expect(repositoriesView.tableView.numberOfRows(inSection: 0)).toEventually(equal(60))

				})

				it("Check UpdateData", closure: {

					repositoriesView.updateData()
					expect(repositoriesView.tableView.numberOfRows(inSection: 0)).toEventually(beGreaterThan(0))
					expect(repositoriesView.tableView.numberOfRows(inSection: 0)).toEventually(equal(60))

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
}
