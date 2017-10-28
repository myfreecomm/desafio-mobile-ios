//
//  ReachabilityManager.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation
import ReachabilitySwift

class ReachabilityManager {
    
    static var isSubscribed : Bool = false
    private static let reachability = Reachability()
    
    class func subscribe() {
        
        if  let reachability = ReachabilityManager.reachability {
            
            // When reachable...
            reachability.whenReachable = { reachability in
                DispatchQueue.main.async {
                    if reachability.isReachableViaWiFi {
                        print("ReachabilitySwift -> WiFi")
                        //NotificationCenter.default.post(name: NotificationCenter.Name.ReachableViaWifi, object: nil)
                    } else {
                        print("ReachabilitySwift -> 3G")
                        NotificationCenter.default.post(name: NotificationCenter.Name.Reachable, object: nil)
                        //NotificationCenter.default.post(name: NotificationCenter.Name.ReachableVia3G, object: nil)
                    }
                }
            }
            
            // When not...
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
            } catch {
                print("ReachabilitySwift -> Unable to start notifier")
            }
        }
    }
    
    class func unsubscribe() {
        if  let reachability = ReachabilityManager.reachability {
            reachability.stopNotifier()
            ReachabilityManager.isSubscribed = false
        }
    }
}

