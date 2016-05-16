// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RepoCD.swift instead.

import Foundation
import CoreData

public enum RepoCDAttributes: String {
    case repoDesc = "repoDesc"
    case repoForks = "repoForks"
    case repoFullName = "repoFullName"
    case repoId = "repoId"
    case repoIssues = "repoIssues"
    case repoName = "repoName"
    case repoStars = "repoStars"
    case repoUrl = "repoUrl"
}

public enum RepoCDRelationships: String {
    case repoOwner = "repoOwner"
}

public class _RepoCD: NSManagedObject {

    // MARK: - Class methods

    public class func entityName () -> String {
        return "RepoCD"
    }

    public class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _RepoCD.entity(managedObjectContext) else { return nil }
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var repoDesc: String

    @NSManaged public
    var repoForks: NSNumber?

    @NSManaged public
    var repoFullName: String

    @NSManaged public
    var repoId: NSNumber?

    @NSManaged public
    var repoIssues: NSNumber?

    @NSManaged public
    var repoName: String

    @NSManaged public
    var repoStars: NSNumber?

    @NSManaged public
    var repoUrl: String

    // MARK: - Relationships

    @NSManaged public
    var repoOwner: RepoOwnerCD?

}

