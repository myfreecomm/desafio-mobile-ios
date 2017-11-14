//
//  PullRequestsViewControllerTests.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import XCTest
@testable import DesafioIOS

class PullRequestsViewControllerTests: XCTestCase {
    
    fileprivate var vc : MockPullRequestsViewController! = nil
    fileprivate let timeOutInterval : TimeInterval = 10.0
    fileprivate let fakeDict : [String:Any] = [
        "id" : 12345,
        "name" : "elasticsearch",
        "full_name" : "elastic/elasticsearch",
        "description" : "Lorem ipsum dolor sit amen",
        "forks_count" : 999,
        "stargazers_count" : 999,
        "owner" : [
            "id" : "fake_id",
            "login" : "elastic",
            "avatar_url" : "http://fakeavatar.com/avatar.png"
        ]
    ]
    
    // MARK: - Lifecycle Methods
    override func setUp() {
        super.setUp()
        let repository = Repository(jsonData: fakeDict)
        self.vc = MockPullRequestsViewController()
        self.vc.viewModel = PullRequestsViewModel(repository: repository)
    }
    
    override func tearDown() {
        self.vc = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testRefresh() {
        
        // Assert View Controller wasn't refreshed yet
        XCTAssertFalse(vc.didRefresh == true, "O View Controller não pode ter sido recarregado nesta fase.")
        
        // Launch
        vc.refresh()
        
        // Assert View Controller was refreshed
        XCTAssert(vc.didRefresh == true, "O View Controller deve ter sido recarregado nesta fase.")
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
    
    func testActionBack() {
        
        // Assert View Controller wasn't popped yet
        XCTAssertFalse(vc.didGoBack == true, "O View Controller não pode ter sido fechado nesta fase.")
        
        // Launch
        vc.actionBack()
        
        // Assert View Controller was popped
        XCTAssert(vc.didGoBack == true, "O View Controller deve ter sido fechado nesta fase.")
    }
    
    func testAddObservers() {
        
        // Try to Add observers
        self.vc.addObservers()
        
        // Test proprieties
        XCTAssertNotNil(self.vc.hasObservers, "Este View Controller não possui Observers.")
        XCTAssert(self.vc.hasObservers == true, "Não foram adicionados observers neste View Controller")
        
        // Remove observers
        self.vc.removeObservers()
    }
    
    func testRemoveObservers() {
        
        // Try to Add observers
        self.vc.addObservers()
        // Remove observers
        self.vc.removeObservers()
        
        // Test proprieties
        XCTAssertNotNil(self.vc.hasObservers, "Este View Controller possui Observers.")
        XCTAssert(self.vc.hasObservers == false, "Este View Controller possui Observers")
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

