//
//  NetworkTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
@testable import javahub

class NetworkTests: QuickSpec {

	let stubs = Stubs()

	override func setUp() {
		super.setUp()

		self.stubs.stubGetConnection(file: "NetworkHandlerMock", host: "localhost", in: "/simple")
	}

	override func spec() {
		
        describe("Test NetworkHandler") {

			var networkHandler: NetworkInterface!
			context("Request", closure: {

				beforeEach {

                    // Run before each test
					networkHandler = Network()

                }

                afterEach{

                     // Run after each test
					 self.stubs.clearStubs()
                }

                // Puts test code here

				it("Test GET", closure: { waitUntil { done in

					networkHandler.request("http://localhost/simple", operation: .get, header: nil, params: nil, completion: { (result, error) in

						expect(result!).toNot(beNil())
						expect(result!["result"]["message"].string!).to(equal("json request mock"))
						done()
					})
				}})
            })
        }
	}
}
