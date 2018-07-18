//
//  RouterTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
@testable import javahub

class RouterTests: QuickSpec {

	override func spec() {
		
        describe("Test Router") {

			context("On init", closure: {

				var routerView: RouterView!
				var routerPresenter: Router!
				beforeEach {

					// Run before each test
					 routerView = RouterView()
					 routerPresenter = Router(view: routerView)
					 routerView.presenter = routerPresenter
                }

                afterEach{

                     // Run after each test
                }

                // Puts test code here
				it("Check Presenter in View", closure: {

					expect(routerView.presenter).toNot(beNil())
				})

				it("Check View in Presenter", closure: {

					expect(routerPresenter.view).toNot(beNil())
				})

				it("RouterView Navigate to Repositories", closure: {

					routerView.presenter?.goTo(destiny: .repositories, pushForward: nil)
					expect(routerView.visibleViewController).toEventually(beAnInstanceOf(RepositoriesViewController.self))
				})

				it("RouterView Navigate to PullRequests", closure: {

					routerView.presenter?.goTo(destiny: .pullrequests, pushForward: nil)
					expect(routerView.visibleViewController).toEventually(beAnInstanceOf(PullRequestsViewController.self))
				})
            })

			context("Router", closure:{

				var routerView: RouterView!
				var routerPresenter: Router!
				beforeEach {

					// Run before each test
					routerView = RouterView()
					routerPresenter = Router(view: routerView)
					routerView.presenter = routerPresenter
				}

				it("Check method goTo", closure: {

					routerPresenter.goTo(destiny: .repositories, pushForward: nil)
					expect(routerView.visibleViewController).toEventually(beAnInstanceOf(RepositoriesViewController.self))
				})

				it("Check buildView", closure: {

					let view = routerPresenter.buildView(Routes.repositories.file, RepositoriesViewController.identifier, RepositoriesViewController.self)
					expect(view).toEventually(beAnInstanceOf(RepositoriesViewController.self))
				})
			})
        }
	}
}
