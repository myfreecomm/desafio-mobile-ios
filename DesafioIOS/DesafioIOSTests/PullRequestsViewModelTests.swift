//
//  PullRequestsViewModelTests.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import XCTest
@testable import DesafioIOS

class PullRequestsViewModelTests: XCTestCase {
    
    fileprivate var vm : MockPullRequestsViewModel! = nil
    fileprivate let timeOutInterval : TimeInterval = 5.0
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
        self.vm = MockPullRequestsViewModel()
    }
    
    override func tearDown() {
        self.vm = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testRefresh() {
        
        // Launch
        self.vm.refresh()
        
        // Assert
        XCTAssertNotNil(self.vm.didRefreshPage, "Os dados não foram recarregados.")
    }
    
    func testFetchData() {
        
        // Apply it
        let fakeObject = Repository(jsonData: fakeDict)
        self.vm.repository = fakeObject
        
        // Expectation
        let expectation = self.expectation(description: "Esperando dados de de Pull Requests")
        
        // Launch
        let previousSourceCount = vm.source.count
        vm.fetchData { [weak self] in
            if  let this = self {
                // Assert
                XCTAssert(previousSourceCount < this.vm.source.count, "O conteúdo da coleção de dados é menor ou igual à conferência anterior.")
            }
            expectation.fulfill()
        }
        
        // Assert
        self.waitForExpectations(timeout: self.timeOutInterval, handler: nil)
    }
}

// MARK: - Mock Data
class MockPullRequestsViewModel : PullRequestsViewModel {
    
    var didRefreshPage : Bool? = nil
    
    override func refresh() {
        super.refresh()
        self.didRefreshPage = true
    }
}


