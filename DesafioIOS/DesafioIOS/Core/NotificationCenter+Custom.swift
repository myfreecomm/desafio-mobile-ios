//
//  NotificationCenter+Custom.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 08/11/2017.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

extension Notification {
    
    // Notification Names
    enum CustomName : String {
        
        case reachable
        case notReachable
        
        case reloadData
        case didStartLoading
        case didFinishLoading
        case didFinishRefreshing
        case didReceiveError
        
        case preparePullsCount
        case launchUrl
        
        func asNotificationName() -> Notification.Name {
            return Notification.Name(self.rawValue)
        }
    }
}

extension NotificationCenter {
    
    func post(_ custom: Notification.CustomName, object: Any? = nil) {
        post(name: custom.asNotificationName(), object: object)
    }
    
    func subscribe(observer: Any, selector: Selector, custom: Notification.CustomName, object: Any? = nil) {
        addObserver(
            observer, selector: selector, name: custom.asNotificationName(), object: object)
    }
    
    func unsubscribe(observer: Any) {
        removeObserver(observer)
    }
}
