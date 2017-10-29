//
//  MockWebViewController.swift
//  DesafioIOSTests
//
//  Created by Felipe Ricieri on 29/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

@testable import DesafioIOS

class MockWebViewController : WebViewController {
    
    var notificationReceived : String? = nil
    
    var didLoadWebView : Bool = false
    var didReload : Bool = false
    var didDismissed : Bool = false
    var hasObservers : Bool? = nil
    
    override func loadWebView() {
        super.loadWebView()
        self.didLoadWebView = true
    }
    
    override func actionReload() {
        super.actionReload()
        self.didReload = true
    }
    
    override func actionDismiss() {
        super.actionDismiss()
        self.didDismissed = true
    }
    
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

