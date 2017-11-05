//
//  DataService.swift
//  JavaPop
//
//  Created by Esdras Emanuel on 02/11/17.
//  Copyright © 2017 evtApps. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class DataService{
    
    static let instance = DataService()
    
    private init(){
        
    }
    
    func nextPageLinkFrom(headers: [AnyHashable : Any]) -> String{
        var res = String()
        if let link = headers["Link"] as? String{
            let linkArr = link.components(separatedBy: " ")
            res = linkArr[0]
            res.removeFirst()
            res.removeLast()
            res.removeLast()
        }
        return res
    }
    
    func lastPageLinkFrom(headers: [AnyHashable : Any]) -> String{
        var res = String()
        if let link = headers["Link"] as? String{
            let linkArr = link.components(separatedBy: " ")
            res = linkArr[2]
            res.removeFirst()
            res.removeLast()
            res.removeLast()
        }
        return res
    }
    
    func presentError(message: String){
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
