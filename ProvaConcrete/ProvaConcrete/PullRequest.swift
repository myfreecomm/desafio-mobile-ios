//
//  PullRequest.swift
//  ProvaConcrete
//
//  Created by MacBook Pro i7 on 04/08/17.
//  Copyright © 2017 Claudio. All rights reserved.
//

import Foundation


import CoreData
import Foundation
//import MTLManagedObjectAdapter
import Mantle

// An enums to store the availability status for the given product. It gets converted from values true/false to Available/Unavailable.
enum Availability: String {
    case Available
    case Unavailable
}

// PullRequest conforms to these 3 protocols required for converting JSON to Mantle object and then to core data entity.
//class PullRequest: MTLModel, MTLJSONSerializing, MTLManagedObjectSerializing {
//    var categoryIdentifier: String = ""
//    var averageOverallRating: NSNumber = 0
//    var availability: String = Availability.Unavailable.rawValue
//    var imageURL: NSURL? = nil
//    var listPrice: NSNumber = 0
//    
//    // JSON keys paths for automatically converting incoming JSON into Mantle object with corresponding keys.
//    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
//        return ["averageOverallRating" as NSObject: "average_overall_rating",
//                "availability": "has_stock",
//                "imageURL": "image_url",
//                "listPrice": "list_price",
//                "categoryIdentifier": "category_id"]
//    }
//    
//    // A transformer function to convert incoming imageURL string into Mantle imageURL object which is of type NSURL.
//    static func imageURLJSONTransformer() -> NSValueTransformer {
//        return NSValueTransformer(forName: MTLURLValueTransformerName)!
//    }
//    
//    // A transformer function to convert bool availability values into corresponding enum Available/Unavailable respectively.
//    static func availabilityJSONTransformer() -> NSValueTransformer {
//        return NSValueTransformer.mtl_valueMappingTransformerWithDictionary([true: "Available", false: "Unavailable"])
//    }
//    
//    // MARK: MTLManagedObjectSerializing protocol method. This tells the Mantle the name of core data entity corresponding to Mantle object. Since we used the same entity name for both Mantle and Core data, we will return Product object back.
//    static func managedObjectEntityName() -> String! {
//        return "Product"
//    }
//    
//    // For mapping Mantle keys to Core data object model keys.
//    static func managedObjectKeysByPropertyKey() -> [NSObject : AnyObject]! {
//        return ["categoryIdentifier": "categoryIdentifier",
//                "availability": "availability",
//                "averageOverallRating": "averageOverallRating",
//                "imageURL": "imageURL",
//                "listPrice": "listPrice"]
//    }
//    
//    // An inverse transform to oncvert imageURL object which if of NSURL into Strign object.
//    static func imageURLEntityAttributeTransform() -> NSValueTransformer {
//        return NSValueTransformer(forName: MTLURLValueTransformerName)!.mtl_invertedTransformer()
//    }    
//}
