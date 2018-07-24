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

@testable import javahub

class PullRequestsTests: QuickSpec {

	let stubs: Stubs = Stubs()
	let localRepoJson: JSON = Stubs.loadFile(with: "listRepositoriesMock", in: PullRequestTests.self)
	let localPullJson: JSON = Stubs.loadFile(with: "listPullRequestsMock", in: PullRequestTests.self)

	override func setUp() {
		super.setUp()
		self.stubs.stubGetConnection(file: "listPullRequestsMock", host: "localhost", in: "/repos/iluwatar/java-design-patterns/pulls")
	}

	override func spec() {
		
        describe("Tests PullRequests class") {

			afterSuite {

				self.stubs.clearStubs()
			}

			context("", closure: {

				var pullRequests: PullRequests!
				var pullRequestsView: PullRequestsViewController!
				beforeEach {

					// Run before each test
					pullRequestsView = UIStoryboard(name: Routes.pullrequests.file, bundle: nil).instantiateViewController(withIdentifier: PullRequestsViewController.identifier)  as! PullRequestsViewController
					pullRequests = PullRequests(view: pullRequestsView, router: RouterView.sharedInstance.presenter!, repository:  Repository.generate(json: self.localRepoJson["items"].array![0]))
					pullRequestsView.presenter = pullRequests
					pullRequestsView.loadViewIfNeeded()


					// Run before each test
					let navController = RouterView()
					navController.presenter = Router(view: navController)
					navController.loadViewIfNeeded()
					navController.setViewControllers([pullRequestsView], animated: true)

					let delegate = UIApplication.shared.delegate as! AppDelegate
					delegate.window = UIWindow(frame: UIScreen.main.bounds)
					delegate.window?.rootViewController = navController
					delegate.window?.makeKeyAndVisible()
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

//				Methods
				it("repositories not empty after request", closure: {

					pullRequests.requestItens()
					expect(pullRequests.repository.pullrequests.count).toEventually(beGreaterThan(0))
				})

				it("buildCell must build and return a cell", closure: {

//					pullRequests.repository.pullrequests = [PullRequest()]
					let cell = pullRequests.buildCell(to: pullRequestsView.tableView, at: IndexPath(row: 0, section: 0))
					expect(cell).toNot(beNil())
				})

//				Teste mostra resultados inconsistente. Deve ser reavaliado.
//				it("showItem open browser", closure: {
//
//					pullRequests.pullrequests = PullRequest.generateMany(json: self.localPullJson)
//					pullRequests.showItem(at: 0)
//
////					waitUntil(timeout: 12) { done in
//					waitUntil { done in
//						if UIApplication.shared.applicationState == .inactive { done() }
//						if UIApplication.shared.applicationState == .background { done() }
//					}
//				})

//				it("incrementPage must increment page", closure: {
//
//					pullRequests.incrementPage()
//					expect(pullRequests.page).to(equal(2))
//				})

//				it("resetData must set page for 1", closure: {
//
//					pullRequests.resetData()
//					expect(pullRequests.page).to(equal(1))
//					expect(pullRequests.pullrequests.count).to(equal(0))
//					expect(pullRequests.sizeList).to(equal(0))
//				})
            })
        }
	}
}
