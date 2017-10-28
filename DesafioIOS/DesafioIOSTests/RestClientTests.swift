//
//  RestClientTests.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import XCTest
@testable import DesafioIOS

class RestClientTests: XCTestCase {
    
    fileprivate let timeOutInterval : TimeInterval = 10.0
    
    func testSendRequest() {
        
        // Expectation
        let expectation = self.expectation(description: "Esperando resultado de Rest Client (pull requests)")
        
        // Launch
        RestClient.sendRequest(url: "https://api.github.com/repos/elastic/elasticsearch/pulls") { (succeed, result) in
            XCTAssert(succeed, "A requisição falhou.")
            XCTAssertNotNil(result, "A resposta é nula.")
            if  let safeResult = result {
                XCTAssert(safeResult is [[String:Any]], "A resposta não é uma coleção de dados.")
            }
            expectation.fulfill()
        }
        
        // Assert
        self.waitForExpectations(timeout: self.timeOutInterval, handler: nil)
    }
}
