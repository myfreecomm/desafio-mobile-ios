// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RepoOwnerCD.swift instead.

import Foundation
import CoreData

public enum RepoOwnerCDAttributes: String {
    case ownerAvatar = "ownerAvatar"
    case ownerId = "ownerId"
    case ownerName = "ownerName"
}

public enum RepoOwnerCDRelationships: String {
    case repo = "repo"
}

public class _RepoOwnerCD: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "RepoOwnerCD"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _RepoOwnerCD.entity(managedObjectContext) else { return nil }
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var ownerAvatar: String?

    @NSManaged public
    var ownerId: NSNumber?

    @NSManaged public
    var ownerName: String?

    // MARK: - Relationships

    @NSManaged public
    var repo: RepoCD?

}

