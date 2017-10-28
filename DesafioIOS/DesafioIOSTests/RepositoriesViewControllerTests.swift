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
    func testSetup() {
        
        // Init view
        var view : UIView? = self.vc.view
        
        // Asserting proprieties
        XCTAssertNotNil(view, "Este View Controller não possui UIView.")
        XCTAssertNotNil(self.vc.tableView, "UITableView não existe.")
        XCTAssert(self.vc.tableView.rowHeight == UITableViewAutomaticDimension, "A altura das células da UITableView não é dinâmica.")
        XCTAssert(self.vc.tableView.estimatedRowHeight == 130, "A altura das células da UITableView não é 130px.")
        XCTAssertNotNil(self.vc.tableView.refreshControl, "UITableView não possui UIRefreshControl.")
        
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
    
    func testRefresh() {
        
        // Expectation
        let expectation = self.expectation(description: "Carregar dados")
        
        // Fetch Data to fill source
        self.vc.fetchData { [weak self] in
            if  let this = self {
                // Assert
                XCTAssert(this.vc.source.count > 0, "A coleção de dados está vazia.")
                // Fetch second page
                this.vc.triggerInfiniteScrolling { [unowned this] in
                    // Assert
                    XCTAssert(this.vc.page > 1, "A página ainda é a primeira.")
                    expectation.fulfill()
                    // Try to refresh
                    this.vc.refresh()
                    // Assert
                    XCTAssert(this.vc.page == 1, "A página ativa não é a primeira")
                }
            }
        }
        
        // Wait
        self.waitForExpectations(timeout: self.timeOutInterval, handler: nil)
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
    
    func testFetchData() {
        
        // Expectation
        let expectation = self.expectation(description: "Esperando dados da primeira página de Repositories")
        
        // Launch
        let previousSourceCount = self.vc.source.count
        self.vc.fetchData { [weak self] in
            if  let this = self {
                // Assert
                XCTAssert(previousSourceCount < this.vc.source.count, "O conteúdo da coleção de dados é menor ou igual à conferência anterior.")
            }
            expectation.fulfill()
        }
        
        // Assert
        self.waitForExpectations(timeout: self.timeOutInterval, handler: nil)
    }
    
    func testTriggerInfiniteScrolling() {
        
        // Fetch first page
        self.vc.fetchData { [weak self] in
            if  let this = self {
                // Expectation
                let expectation = this.expectation(description: "Esperando dados da próxima página de Repositories")
                
                // Launch
                let previousSourceCount = this.vc.source.count
                this.vc.triggerInfiniteScrolling { [unowned this] in
                    // Assert
                    XCTAssert(previousSourceCount < this.vc.source.count, "O conteúdo da coleção de dados é menor ou igual à conferência anterior.")
                    XCTAssert(this.vc.page > 1, "A página continua sendo a primeira.")
                    expectation.fulfill()
                }
                
                // Assert
                this.waitForExpectations(timeout: this.timeOutInterval, handler: nil)
            }
        }
    }
}

// MARK: - Mock VC
class MockRepositoriesViewController : RepositoriesViewController {
    
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


