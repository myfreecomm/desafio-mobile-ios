//
//  RepositoryService.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import XCTest
@testable import DesafioIOS

class RepositoryServiceTests : XCTestCase {
    
    fileprivate let timeOutInterval : TimeInterval = 10.0
    
    func testLoad() {
        
        // Expectation
        let expectation = self.expectation(description: "Esperando resultado de Repositories")
        
        // Launch
        let service = RepositoryService()
        service.load(page: 1, succeed: { (result) in
            XCTAssert(result.count > 0, "Não houveram resultados.")
            expectation.fulfill()
        }) { (error) in
            XCTAssert(error != "", "Descrição do erro falhou.")
            expectation.fulfill()
        }
        
        // Assert
        self.waitForExpectations(timeout: timeOutInterval, handler: nil)
    }
}
