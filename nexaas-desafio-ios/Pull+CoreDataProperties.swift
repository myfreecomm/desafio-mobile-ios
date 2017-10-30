//
//  Pull+CoreDataProperties.swift
//  nexaas-desafio-ios
//
//  Created by Rogerio Cervasio on 29/10/17.
//  Copyright © 2017 ACME. All rights reserved.
//

import Foundation
import CoreData


extension Pull {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pull> {
        return NSFetchRequest<Pull>(entityName: "Pull")
    }

    @NSManaged public var body: String?
    @NSManaged public var created_at: NSDate?
    @NSManaged public var diff_url: String?
    @NSManaged public var html_url: String?
    @NSManaged public var id: Int64
    @NSManaged public var issue_url: String?
    @NSManaged public var locked: Bool
    @NSManaged public var message: String?
    @NSManaged public var number: Int64
    @NSManaged public var patch_url: String?
    @NSManaged public var state: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var user_avatar_url: String?
    @NSManaged public var user_login: String?

}
