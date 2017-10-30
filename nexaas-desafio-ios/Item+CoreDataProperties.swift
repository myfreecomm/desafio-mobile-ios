//
//  Item+CoreDataProperties.swift
//  nexaas-desafio-ios
//
//  Created by Rogerio Cervasio on 29/10/17.
//  Copyright © 2017 ACME. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var forks: Int64
    @NSManaged public var forks_count: Int64
    @NSManaged public var full_name: String?
    @NSManaged public var id: Int64
    @NSManaged public var itemDescription: String?
    @NSManaged public var name: String?
    @NSManaged public var open_issues: Int64
    @NSManaged public var open_issues_count: Int64
    @NSManaged public var owner_avatar_url: String?
    @NSManaged public var owner_id: Int64
    @NSManaged public var owner_login: String?
    @NSManaged public var owner_type: String?
    @NSManaged public var owner_url: String?
    @NSManaged public var stargazers_count: Int64
    @NSManaged public var watchers: Int64
    @NSManaged public var watchers_count: Int64

}
