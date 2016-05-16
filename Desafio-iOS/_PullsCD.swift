// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PullsCD.swift instead.

import Foundation
import CoreData

public enum PullsCDAttributes: String {
    case pullBody = "pullBody"
    case pullDate = "pullDate"
    case pullId = "pullId"
    case pullTitle = "pullTitle"
    case pullUrl = "pullUrl"
}

public enum PullsCDRelationships: String {
    case pullUser = "pullUser"
}

public class _PullsCD: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "PullsCD"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _PullsCD.entity(managedObjectContext) else { return nil }
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var pullBody: String

    @NSManaged public
    var pullDate: NSDate?

    @NSManaged public
    var pullId: NSNumber?

    @NSManaged public
    var pullTitle: String

    @NSManaged public
    var pullUrl: String

    // MARK: - Relationships

    @NSManaged public
    var pullUser: PullsUserCD?

}

