//
//  RepositoriesViewModelTests.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import XCTest
@testable import DesafioIOS

class RepositoriesViewModelTests: XCTestCase {
    
    fileprivate var vm : RepositoriesViewModel! = nil
    fileprivate let timeOutInterval : TimeInterval = 5.0
    
    // MARK: - Lifecycle Methods
    override func setUp() {
        super.setUp()
        self.vm = RepositoriesViewModel()
    }
    
    override func tearDown() {
        self.vm = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testRefresh() {
        
        // Expectation
        let expectation = self.expectation(description: "Carregar dados")
        
        // Fetch Data to fill source
        vm.fetchData { [weak self] in
            if  let this = self {
                // Assert
                XCTAssert(this.vm.source.count > 0, "A coleção de dados está vazia.")
                // Fetch second page
                this.vm.triggerInfiniteScrolling { [unowned this] in
                    // Assert
                    XCTAssert(this.vm.page > 1, "A página ainda é a primeira.")
                    expectation.fulfill()
                    // Try to refresh
                    this.vm.refresh()
                    // Assert
                    XCTAssert(this.vm.page == 1, "A página ativa não é a primeira")
                }
            }
        }
        
        // Wait
        self.waitForExpectations(timeout: self.timeOutInterval, handler: nil)
    }
    
    func testFetchData() {
        
        // Expectation
        let expectation = self.expectation(description: "Esperando dados da primeira página de Repositories")
        
        // Launch
        let previousSourceCount = self.vm.source.count
        self.vm.fetchData { [weak self] in
            if  let this = self {
                // Assert
                XCTAssert(previousSourceCount < this.vm.source.count, "O conteúdo da coleção de dados é menor ou igual à conferência anterior.")
            }
            expectation.fulfill()
        }
        
        // Assert
        self.waitForExpectations(timeout: self.timeOutInterval, handler: nil)
    }
    
    func testTriggerInfiniteScrolling() {
        
        // Fetch first page
        self.vm.fetchData { [weak self] in
            if  let this = self {
                // Expectation
                let expectation = this.expectation(description: "Esperando dados da próxima página de Repositories")
                
                // Launch
                let previousSourceCount = this.vm.source.count
                this.vm.triggerInfiniteScrolling { [unowned this] in
                    // Assert
                    XCTAssert(previousSourceCount < this.vm.source.count, "O conteúdo da coleção de dados é menor ou igual à conferência anterior.")
                    XCTAssert(this.vm.page > 1, "A página continua sendo a primeira.")
                    expectation.fulfill()
                }
                
                // Assert
                this.waitForExpectations(timeout: this.timeOutInterval, handler: nil)
            }
        }
    }
}

