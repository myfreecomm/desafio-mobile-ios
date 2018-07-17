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
		
        describe("Navigation Tests") {

			context("", closure: {

				beforeEach {

                    // Run before each test

                }

                afterEach{

                     // Run after each test
                }

                // Puts test code here
				it("Be true", closure: {

					expect(10).to(equal(10))
				})
            })
        }
	}
}
