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
        self.vc = MockPullRequestsViewController()
    }
    
    override func tearDown() {
        self.vc = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testSetup() {
        
        // Apply it
        let fakeObject = Repository(jsonData: fakeDict)
        vc.viewModel.repository = fakeObject
        
        // Init view
        var view : UIView? = self.vc.view
        
        // Asserting proprieties
        XCTAssertNotNil(view, "Este View Controller não possui UIView.")
        XCTAssertNotNil(vc.tableView, "UITableView não existe.")
        XCTAssertNotNil(vc.viewModel.repository, "Esta tela requere um objeto do tipo \"Repository\" para continuar.")
        XCTAssert(vc.title == vc.viewModel.repository?.name, "O título deve ser o nome do repositório.")
        XCTAssert(vc.navigationItem.title == self.vc.viewModel.repository?.name, "O título deve ser o nome do repositório.")
        XCTAssert(vc.tableView.rowHeight == UITableViewAutomaticDimension, "A altura das células da UITableView não é dinâmica.")
        XCTAssert(vc.tableView.estimatedRowHeight == 140, "A altura das células da UITableView não é 130px.")
        XCTAssertNotNil(vc.tableView.refreshControl, "UITableView não possui UIRefreshControl.")
        
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

// MARK: - Mock VC
class MockPullRequestsViewController : PullRequestsViewController {
    
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


