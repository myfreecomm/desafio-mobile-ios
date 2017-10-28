//
//  WebViewControllerTests.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import XCTest
@testable import DesafioIOS

class WebViewControllerTests: XCTestCase {
    
    fileprivate var vc : MockWebViewController! = nil
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
        self.vc = MockWebViewController()
    }
    
    override func tearDown() {
        self.vc = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testSetup() {
        
        // Apply it
        let fakeObject = PullRequest(data: fakeDict)
        self.vc.pullRequest = fakeObject
        
        // Init view
        var view : UIView? = self.vc.view
        
        // Asserting proprieties
        XCTAssertNotNil(view, "Este View Controller não possui UIView.")
        XCTAssertNotNil(self.vc.pullRequest, "Esta tela requere um objeto do tipo \"Pull Request\" para continuar.")
        XCTAssert(self.vc.title == "", "O título deve ser o nome do pull request.")
        XCTAssert(self.vc.navigationItem.title == "", "O título deve ser o nome do repositório.")
        
        // Release View
        view = nil
    }
    
    func testLaunchUrl() {
        
        // Apply it
        let fakeObject = PullRequest(data: fakeDict)
        self.vc.pullRequest = fakeObject
        
        // Init view
        var view : UIView? = self.vc.view
        
        // Fire
        self.vc.launchUrl()
        
        // Assert
        XCTAssertNotNil(view, "Este View Controller não possui UIView.")
        XCTAssertNotNil(self.vc.url, "A URL ainda não foi carregada.")
        XCTAssert(self.vc.title == self.vc.pullRequest?.title, "O título deve ser o nome do pull request.")
        XCTAssert(self.vc.navigationItem.title == self.vc.pullRequest?.title, "O título deve ser o nome do repositório.")
        
        // Release View
        view = nil
    }
    
    func testAddObservers() {
        
        // Try to Add observers
        self.vc.addObservers()
        
        // Test proprieties
        XCTAssertNotNil(self.vc.hasObservers, "Este View Controller não possui Observers.")
        XCTAssert(self.vc.hasObservers == true, "Não foram adicionados observers neste View Controller")
        
        // Try to Add observers
        self.vc.removeObservers()
    }
    
    func testRemoveObservers() {
        
        // Try to Add observers
        self.vc.addObservers()
        // Try to Add observers
        self.vc.removeObservers()
        
        // Test proprieties
        XCTAssertNotNil(self.vc.hasObservers, "Este View Controller possui Observers.")
        XCTAssert(self.vc.hasObservers == false, "Este View Controller possui Observers")
    }
}

// MARK: - Mock VC
class MockWebViewController : WebViewController {
    
    var notificationReceived : String? = nil
    var hasObservers : Bool? = nil
    
    override func addObservers() {
        super.addObservers()
        self.hasObservers = true
    }
    
    override func removeObservers() {
        super.removeObservers()
        self.hasObservers = false
    }
    
    override func notificationIsReachable(n: Notification) {
        super.notificationIsReachable(n: n)
        self.notificationReceived = n.name.rawValue
    }
    
    override func notificationNotReachable(n: Notification) {
        super.notificationNotReachable(n: n)
        self.notificationReceived = n.name.rawValue
    }
}


