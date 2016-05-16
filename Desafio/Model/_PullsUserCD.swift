// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PullsUserCD.swift instead.

import Foundation
import CoreData

public enum PullsUserCDAttributes: String {
    case userAvatar = "userAvatar"
    case userId = "userId"
    case userName = "userName"
}

public enum PullsUserCDRelationships: String {
    case pulls = "pulls"
}

public class _PullsUserCD: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "PullsUserCD"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _PullsUserCD.entity(managedObjectContext) else { return nil }
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var userAvatar: String?

    @NSManaged public
    var userId: NSNumber?

    @NSManaged public
    var userName: String?

    // MARK: - Relationships

    @NSManaged public
    var pulls: PullsCD?

}

