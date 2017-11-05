//
//  JavaPopTests.swift
//  JavaPopTests
//
//  Created by Esdras Emanuel on 20/10/17.
//  Copyright © 2017 evtApps. All rights reserved.
//

import XCTest
import Foundation

@testable import JavaPop

class JavaPopTests: XCTestCase {
    
    var mainVC : MainVC!

    override func setUp() {
        super.setUp()
        mainVC = MainVC()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testNextStringFromHeader(){
        let headers : [AnyHashable : Any] = [
            "Link" : "<https://api.github.com/search/repositories?q=language%3AJava&sort=stars&page=2>; rel=\"next\", <https://api.github.com/search/repositories?q=language%3AJava&sort=stars&page=34>; rel=\"last\""
        ]
        let res = mainVC.nextPageLinkFrom(headers: headers)
        XCTAssert(res == "https://api.github.com/search/repositories?q=language%3AJava&sort=stars&page=2")
    }
    
    func testLastPageCheck(){
        var url : String
        url = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=34"
        mainVC.setLastUrl(url: url)
        mainVC.loadData(url: url)
        XCTAssert(mainVC.isInLastPage())
    }
}

