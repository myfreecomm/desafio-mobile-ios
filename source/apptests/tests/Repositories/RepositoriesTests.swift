//
//  Repositories.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 18/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
@testable import javahub

class RepositoriesTests: QuickSpec {

	let stubs = Stubs()

	override func setUp() {
		super.setUp()
	}

	override func spec() {
		
        describe("Test Repositories class") {

			context("", closure: {

				var repositoriesView: RepositoriesViewController!
				var repositories: Repositories!
				var navController: RouterView!

				beforeEach {

                    // Run before each test
					self.stubs.stubGetConnection(file: "listRepositoriesMock", host: "localhost", in: "/search/repositories?q=language:Java&sort=stars&page=1")

					navController = RouterView()
					navController.loadViewIfNeeded()
					navController.presenter = Router(view: navController)
					navController.presenter!.goTo(destiny: .repositories, pushForward: nil)

					repositoriesView = navController.visibleViewController as! RepositoriesViewController
					repositoriesView.loadViewIfNeeded()

					repositories = repositoriesView.presenter as! Repositories

					let delegate = UIApplication.shared.delegate as! AppDelegate
					delegate.window = UIWindow(frame: UIScreen.main.bounds)
					delegate.window?.rootViewController = navController
					delegate.window?.makeKeyAndVisible()

                }

                afterEach{

                     // Run after each test
					self.stubs.clearStubs()
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

//				Methods

				it("repositories not empty after request", closure: {

					repositories.requestItens()
					expect(repositories.repositories.count).toEventually(beGreaterThan(0))
				})

				it("buildCell must build and return a cell", closure: {

					repositories.repositories = [Repository()]
					let cell = repositories.buildCell(to: repositoriesView.tableView, at: IndexPath(row: 0, section: 0))
					expect(cell).toNot(beNil())
				})

				it("showItem must show PullrequestView", closure: {

					repositories.repositories = [Repository()]
					repositories.showItem(at: 0)
					expect(navController.visibleViewController).toEventually(beAnInstanceOf(PullRequestsViewController.self))
				})

				it("incrementPage must increment page", closure: {

					repositories.incrementPage()
					expect(repositories.page).to(equal(2))
				})

				it("resetPage must set page for 1", closure: {

					repositories.resetPage()
					expect(repositories.page).to(equal(1))
				})
            })
        }
	}
}

