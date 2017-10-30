//
//  BaseService.swift
//  nexaas-desafio-ios
//
//  Created by Rogerio Cervasio on 27/10/17.
//  Copyright © 2017 ACME. All rights reserved.
//

import Alamofire
import AlamofireNetworkActivityIndicator

public class BaseService: NSObject {
    
    var manager: Alamofire.SessionManager?
    
    public var baseAddress: String?
    public var baseVersion: String?
    public private(set) var baseAPI: String?
    private var reachabilityManager: NetworkReachabilityManager?
    
    public var reachabilityStatus: NetworkReachabilityManager.NetworkReachabilityStatus? {
        get {
            return self.reachabilityManager?.networkReachabilityStatus
        }
    }
    
    public func startReachabilityMonitoring() {
        
        self.baseAPI = self.baseAddress! + self.baseVersion!
        self.reachabilityManager = NetworkReachabilityManager(host: self.baseAddress!)
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        manager = Alamofire.SessionManager(configuration: configuration)
        
        guard let reachabilityManager = self.reachabilityManager else {
            return
        }
        
        reachabilityManager.listener = { status in
            print("reachabilityManager status: \(status)")
            let isNetworkReachable = reachabilityManager.isReachable
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ReachabilityStatusChangedNotification"), object: isNetworkReachable)
        }
        
        reachabilityManager.startListening()
    }
    
    func stopReachabilityListening() {
        self.reachabilityManager?.stopListening()
    }
    
    func isConnected() -> Bool {
        return (self.reachabilityManager?.isReachable)!
    }
    
    internal func apiRequest(_ method: Alamofire.HTTPMethod, address: String, parameters: [String: Any]? = nil, completion: ((_ finished: Bool, _ response: AnyObject?) -> Void)? = nil) -> Request {
        
        
        var headers: [String: String]?
        
        headers = ["Accept": "application/vnd.github.v3+json"]
        
        return Alamofire.request(address, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            
            if let JSON = response.result.value {
                completion?(true, JSON as AnyObject?)
            } else {
                completion?(false, nil)
            }
            
        }
    }
    
}

