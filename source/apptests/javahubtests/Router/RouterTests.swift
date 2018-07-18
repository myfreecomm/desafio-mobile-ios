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

				beforeEach {

					// Run before each test
					 routerView = RouterView()
					 routerView.presenter = Router(view: routerView)
                }

                afterEach{

                     // Run after each test
                }

                // Puts test code here
				it("Check Presenter", closure: {

					expect(routerView.presenter).toNot(beNil())
				})

				it("Navigate to Repositories", closure: {

					routerView.presenter?.goTo(destiny: .repositories, pushForward: nil)
					expect(routerView.visibleViewController).toEventually(beAnInstanceOf(RepositoriesViewController.self))
				})
            })
        }
	}
}
