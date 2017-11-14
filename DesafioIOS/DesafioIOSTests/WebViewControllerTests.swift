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
    fileprivate let fakeDict : [String:Any] = [
        "id" : 12345,
        "title" : "Fake Title",
        "body" : "Lorem Ipsum Dolor sit amen",
        "description" : "Fake Description",
        "html_url" : "http://google.com",
        "state" : "open",
        "user" : [
            "id" : "fake_id",
            "login" : "fakelogin",
            "avatar_url" : "http://fakeavatar.com/avatar.png"
        ]
    ]
    
    // MARK: - Lifecycle Methods
    override func setUp() {
        super.setUp()
        let pullRequest = PullRequest(jsonData: fakeDict)
        self.vc = MockWebViewController()
        self.vc.viewModel = WebViewModel(pullRequest: pullRequest)
    }
    
    override func tearDown() {
        self.vc = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testLoadWebView() {
        
        // Assert View Model Don't have a valid URL yet
        XCTAssert(vc.didLoadWebView == false, "O View Controller não deve ter carregado a WebView nesta fase.")
        
        // Launch
        vc.loadWebView()
        
        // Assert
        XCTAssert(self.vc.didLoadWebView == true, "O View Controller deve ter carregado a WebView nesta fase.")
    }
    
    func testActionDismiss() {
        
        // Assert View Controller wasn't reloaded yet
        XCTAssertFalse(vc.didDismissed == true, "O View Controller não pode ter sido recarregado nesta fase.")
        
        // Launch
        vc.actionDismiss()
        
        // Assert View Controller was reloaded
        XCTAssert(vc.didDismissed == true, "O View Controller deve ter sido recarregado nesta fase.")
    }
    
    func testAddObservers() {
        
        // Try to Add observers
        vc.addObservers()
        
        // Test proprieties
        XCTAssertNotNil(vc.hasObservers, "Este View Controller não possui Observers.")
        XCTAssert(vc.hasObservers == true, "Não foram adicionados observers neste View Controller")
        
        // Remove observers
        vc.removeObservers()
    }
    
    func testRemoveObservers() {
        
        // Try to Add observers
        vc.addObservers()
        // Remove observers
        vc.removeObservers()
        
        // Test proprieties
        XCTAssertNotNil(vc.hasObservers, "Este View Controller possui Observers.")
        XCTAssert(vc.hasObservers == false, "Este View Controller possui Observers")
    }
    
    func testNotificationIsReachable() {
        
        // Try to Add observers
        vc.addObservers()
        
        // Launch Notification
        NotificationCenter.default.post(.reachable)
        
        // Test proprieties
        XCTAssertNotNil(vc.notificationReceived, "Este View Controller não recebeu notificações.")
        XCTAssert(vc.notificationReceived == Notification.CustomName.reachable.rawValue, "Este View Controller não recebeu a notificação \"\(Notification.CustomName.reachable.rawValue)\".")
        
        // Remove observers
        vc.removeObservers()
    }
    
    func testNotificationNotReachable() {
        
        // Try to Add observers
        vc.addObservers()
        
        // Launch Notification
        NotificationCenter.default.post(.notReachable)
        
        // Test proprieties
        XCTAssertNotNil(vc.notificationReceived, "Este View Controller não recebeu notificações.")
        XCTAssert(vc.notificationReceived == Notification.CustomName.notReachable.rawValue, "Este View Controller não recebeu a notificação \"\(Notification.CustomName.notReachable.rawValue)\".")
        
        // Remove observers
        vc.removeObservers()
    }
}


