//
//  PullRequestsViewControllerTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 20/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON

@testable import javahub

class PullRequestsViewControllerTests: QuickSpec {

	let stubs: Stubs = Stubs()
	let localRepoJson: JSON = Stubs.loadFile(with: "listRepositoriesMock", in: PullRequestsViewController.self)
	let localPullJson: JSON = Stubs.loadFile(with: "listPullRequestsMock", in: PullRequestsViewController.self)

	override func setUp() {
		super.setUp()
		self.stubs.stubGetConnection(file: "listPullRequestsMock", host: "localhost", in: "/repos/iluwatar/java-design-patterns/pulls")
	}

	override func spec() {
		
        describe("Tests for PullRequestsViewController") {

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

				// Methods

				it("Check RequestNewData", closure: {

					pullRequestsView.requestNewData()
					expect(pullRequestsView.tableView.numberOfRows(inSection: 0)).toEventually(beGreaterThan(0))
					expect(pullRequestsView.tableView.numberOfRows(inSection: 0)).toEventually(equal(18))

				})

				it("Check UpdateData", closure: {

					pullRequestsView.updateData()
					expect(pullRequestsView.tableView.numberOfRows(inSection: 0)).toEventually(beGreaterThan(0))
					expect(pullRequestsView.tableView.numberOfRows(inSection: 0)).toEventually(equal(18))

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
}
