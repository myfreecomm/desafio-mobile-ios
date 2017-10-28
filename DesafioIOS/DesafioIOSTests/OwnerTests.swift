//
//  OwnerTests.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import XCTest
@testable import DesafioIOS

class OwnerTests: XCTestCase {
    
    func testInit() {
        
        // Our Fake info
        let fakeDict : [AnyHashable:Any] = [
            "id" : "fake_id",
            "login" : "fakelogin",
            "avatar_url" : "http://fakeavatar.com/avatar.png"
        ]
        
        // Apply it
        let fakeObject = Owner(jsonData: fakeDict)
        
        // Assert
        XCTAssert(fakeObject.id != "", "O campo \"id\" não foi preenchido.")
        XCTAssert(fakeObject.username != "", "O campo \"username\" não foi preenchido.")
        XCTAssert(fakeObject.name != "", "O campo \"name\" não foi preenchido.")
        XCTAssert(fakeObject.picture != "", "O campo \"picture\" não foi preenchido.")
    }
}

