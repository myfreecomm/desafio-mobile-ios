//
//  WebViewModelTests.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 29/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import XCTest
@testable import DesafioIOS

class WebViewModelTests: XCTestCase {
    
    fileprivate var vm : WebViewModel! = nil
    fileprivate let timeOutInterval : TimeInterval = 10.0
    fileprivate let fakeDict : [String:Any] = [
        "id" : 12345,
        "title" : "Fake Title",
        "body" : "Lorem Ipsum Dolor sit amen",
        "html_url" : "http://google.com",
        "user" : [
            "id" : "fake_id",
            "login" : "fakelogin",
            "avatar_url" : "http://fakeavatar.com/avatar.png"
        ]
    ]
    
    // MARK: - Lifecycle Methods
    override func setUp() {
        super.setUp()
        self.vm = WebViewModel()
    }
    
    override func tearDown() {
        self.vm = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testLaunchUrl() {
        
        // Configure
        vm.pullRequest = PullRequest(jsonData: fakeDict)
        vm.didLaunchUrl = { title in
            XCTAssert(title == self.vm.pullRequest?.title, "O título deve ser o nome do pull request.")
        }
        
        // Fire
        vm.launchUrl()
        
        // Assert
        XCTAssertNotNil(vm.pullRequest?.htmlUrl, "A URL não foi carregada.")
    }
}
