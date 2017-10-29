//
//  RepositoriesViewControllerTests.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import XCTest
@testable import DesafioIOS

class RepositoriesViewControllerTests: XCTestCase {
    
    fileprivate var vc : MockRepositoriesViewController! = nil
    fileprivate let timeOutInterval : TimeInterval = 5.0
    
    // MARK: - Lifecycle Methods
    override func setUp() {
        super.setUp()
        self.vc = MockRepositoriesViewController()
    }
    
    override func tearDown() {
        self.vc = nil
        super.tearDown()
    }
    
    // MARK: - Tests
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
    
    func testNotificationIsReachable() {
        
        // Try to Add observers
        self.vc.addObservers()
        
        // Launch Notification
        NotificationCenter.default.post(name: NotificationCenter.Name.Reachable, object: nil)
        
        // Test proprieties
        XCTAssertNotNil(self.vc.notificationReceived, "Este View Controller não recebeu notificações.")
        XCTAssert(self.vc.notificationReceived == NotificationCenter.Name.Reachable.rawValue, "Este View Controller não recebeu a notificação \"\(NotificationCenter.Name.Reachable.rawValue)\".")
        
        // Try to Add observers
        self.vc.removeObservers()
    }
    
    func testNotificationNotReachable() {
        
        // Try to Add observers
        self.vc.addObservers()
        
        // Launch Notification
        NotificationCenter.default.post(name: NotificationCenter.Name.NotReachable, object: nil)
        
        // Test proprieties
        XCTAssertNotNil(self.vc.notificationReceived, "Este View Controller não recebeu notificações.")
        XCTAssert(self.vc.notificationReceived == NotificationCenter.Name.NotReachable.rawValue, "Este View Controller não recebeu a notificação \"\(NotificationCenter.Name.NotReachable.rawValue)\".")
        
        // Try to Add observers
        self.vc.removeObservers()
    }
    
    func testTriggerRefreshControl() {
        
        // Init view
        var view : UIView? = self.vc.view
        
        // Trigger
        self.vc.triggerRefreshControl()
        
        // Assert
        XCTAssertNotNil(view, "Este View Controller não possui UIView.")
        XCTAssert(self.vc.refreshControl!.isRefreshing, "UIRefreshControl não foi ativado.")
        XCTAssert(self.vc.tableView.contentOffset.y != 0, "Content offset da UITableView não está diferente.")
        
        // Release view
        view = nil
    }
}

