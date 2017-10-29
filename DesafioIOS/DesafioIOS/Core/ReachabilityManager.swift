//
//  ReachabilityManager.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation
import ReachabilitySwift

/**
 *  Reachability Manager 🎃
 *  @description    Manager responsible for reporting the connection state to the app
 */
class ReachabilityManager {
    
    /**
     * ReachabilityManager subscription state
     */
    static var isSubscribed : Bool = false
    
    /**
     * Private singleton
     */
    private static let reachability = Reachability()
    private init() {}
    
    /**
     *  subscribe()
     *  @description    Subscribes ReachabilityManager to listen connection state changes
     */
    class func subscribe() {
        
        guard let reachability = ReachabilityManager.reachability else { return }
        
        // When reachable...
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                if  reachability.isReachable {
                    print("ReachabilitySwift -> Reachable")
                    NotificationCenter.default.post(name: NotificationCenter.Name.Reachable, object: nil)
                }
            }
        }
        
        // When not reachable...
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                print("ReachabilitySwift -> Not reachable")
                NotificationCenter.default.post(name: NotificationCenter.Name.NotReachable, object: nil)
            }
        }
        
        // Fire
        do {
            try reachability.startNotifier()
            ReachabilityManager.isSubscribed = true
        } catch let error {
            print("ReachabilitySwift -> Unable to start notifier")
            print("ReachabilitySwift Error -> \(error.localizedDescription)")
        }
    }
    
    /**
     *  unsubscribe()
     *  @description    Unsubscribes ReachabilityManager to listen connection state changes
     */
    class func unsubscribe() {
        if  let reachability = ReachabilityManager.reachability {
            reachability.stopNotifier()
            ReachabilityManager.isSubscribed = false
        }
    }
}

