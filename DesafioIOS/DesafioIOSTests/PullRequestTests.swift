//
//  PullRequestTests.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import XCTest
@testable import DesafioIOS

class PullRequestTests: XCTestCase {
    
    fileprivate let timeOutInterval : TimeInterval = 10.0
    
    func testInit() {
        
        // Our Fake info
        let fakeDict : [String:Any] = [
            "id" : 12345,
            "title" : "Fake Title",
            "body" : "Lorem Ipsum Dolor sit amen",
            "html_url" : "http://google.com",
            "state" : "open",
            "user" : [
                "id" : "fake_id",
                "login" : "fakelogin",
                "avatar_url" : "http://fakeavatar.com/avatar.png"
            ]
        ]
        
        // Apply it
        let fakeObject = PullRequest(data: fakeDict)
        
        // Assert
        XCTAssert(fakeObject.id != 0, "O campo \"id\" não foi preenchido.")
        XCTAssert(fakeObject.title != "", "O campo \"title\" não foi preenchido.")
        XCTAssert(fakeObject.objectDescription != "", "O campo \"objectDescription\" não foi preenchido.")
        XCTAssert(fakeObject.htmlUrl != "", "O campo \"htmlUrl\" não foi preenchido.")
        XCTAssert(fakeObject.state != "", "O campo \"state\" não foi preenchido.")
        // Assert Owner
        XCTAssertNotNil(fakeObject.owner, "O campo \"owner\" não foi preenchido.")
    }
    
    func testLoad() {
        
        // Expectation
        let expectation = self.expectation(description: "Esperando resultado de Pull Requests")
        
        // Launch
        let testOwner = "elastic"
        let testRepository = "elasticsearch"
        PullRequest.load(owner: testOwner, repository: testRepository, succeed: { (result) in
            XCTAssert(result.count > 0, "Não houveram resultados.")
            expectation.fulfill()
        }) { (error) in
            XCTAssert(error != "", "Descrição do erro falhou.")
            expectation.fulfill()
        }
        
        // Assert
        self.waitForExpectations(timeout: self.timeOutInterval, handler: nil)
    }
}

