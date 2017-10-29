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
        
        guard let reachabilityManager = self.reachabilityManager else {
            return
        }
        
        reachabilityManager.listener = { status in
            print("reachabilityManager status: \(status)")
        }
        
        reachabilityManager.startListening()
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

