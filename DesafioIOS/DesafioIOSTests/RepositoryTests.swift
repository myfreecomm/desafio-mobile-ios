//
//  RepositoryTests.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import XCTest
@testable import DesafioIOS

class RepositoryTests: XCTestCase {
    
    fileprivate let timeOutInterval : TimeInterval = 10.0
    
    func testInit() {
        
        // Our Fake info
        let fakeDict : [String:Any] = [
            "id" : 12345,
            "name" : "Fake Name",
            "full_name" : "Fake Name/Full Name",
            "description" : "Lorem ipsum dolor sit amen",
            "forks_count" : 999,
            "stargazers_count" : 999,
            "owner" : [
                "id" : "fake_id",
                "login" : "fakelogin",
                "avatar_url" : "http://fakeavatar.com/avatar.png"
            ]
        ]
        
        // Apply it
        let fakeObject = Repository(data: fakeDict)
        
        // Assert
        XCTAssert(fakeObject.id != 0, "O campo \"id\" não foi preenchido.")
        XCTAssert(fakeObject.name != "", "O campo \"name\" não foi preenchido.")
        XCTAssert(fakeObject.objectDescription != "", "O campo \"objectDescription\" não foi preenchido.")
        XCTAssert(fakeObject.forks != 0, "O campo \"forks\" não foi preenchido.")
        XCTAssert(fakeObject.stars != 0, "O campo \"stars\" não foi preenchido.")
        // Assert Owner
        XCTAssertNotNil(fakeObject.owner, "O campo \"owner\" não foi preenchido.")
    }
    
    func testLoad() {
        
        // Expectation
        let expectation = self.expectation(description: "Esperando resultado de Repositories")
        
        // Launch
        Repository.load(page: 1, succeed: { (result) in
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


