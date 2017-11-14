//
//  ReachabilityManagerTests.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import XCTest
@testable import DesafioIOS

class ReachabilityManagerTests: XCTestCase {
    
    func testSubscribe() {
        
        // Subscribe
        ReachabilityManager.subscribe()
        
        // Assert
        XCTAssert(ReachabilityManager.isSubscribed, "ReachabilityManager não está recebendo eventos.")
        
        // Unsubscribe
        ReachabilityManager.unsubscribe()
    }
    
    func testUnsubscribe() {
        
        // Subscribe
        ReachabilityManager.subscribe()
        
        // Assert
        XCTAssert(ReachabilityManager.isSubscribed, "ReachabilityManager não está recebendo eventos.")
        
        // Unsubscribe
        ReachabilityManager.unsubscribe()
        
        // Assert
        XCTAssertFalse(ReachabilityManager.isSubscribed, "ReachabilityManager está recebendo eventos.")
    }
}

