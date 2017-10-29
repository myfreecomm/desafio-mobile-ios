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
    func testLoadWebView() {
        
        // Assert View Model Don't have a valid URL yet
        XCTAssert(vc.viewModel.pullRequest == nil, "O View Controller não pode possuir uma Pull Request nesta fase.")
        XCTAssert(vc.didLoadWebView == false, "O View Controller não deve ter carregado a WebView nesta fase.")
        
        vc.viewModel.didLaunchUrl = { _ in
            XCTAssertFalse(self.vc.viewModel.pullRequest == nil, "O View Controller deve possuir uma Pull Request nesta fase.")
            self.vc.loadWebView()
            XCTAssert(self.vc.didLoadWebView == true, "O View Controller deve ter carregado a WebView nesta fase.")
        }
        
        // Launch
        vc.viewModel.launchUrl()
    }
    
    func testActionReload() {
        
        // Assert View Controller wasn't reloaded yet
        XCTAssertFalse(vc.didReload == true, "O View Controller não pode ter sido recarregado nesta fase.")
        
        // Launch
        vc.actionReload()
        
        // Assert View Controller was reloaded
        XCTAssert(vc.didReload == true, "O View Controller deve ter sido recarregado nesta fase.")
    }
    
    func testActionDismissed() {
        
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
        
        // Try to Add observers
        vc.removeObservers()
    }
    
    func testRemoveObservers() {
        
        // Try to Add observers
        vc.addObservers()
        // Try to Add observers
        vc.removeObservers()
        
        // Test proprieties
        XCTAssertNotNil(vc.hasObservers, "Este View Controller possui Observers.")
        XCTAssert(vc.hasObservers == false, "Este View Controller possui Observers")
    }
}


