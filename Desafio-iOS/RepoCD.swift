import Foundation
import MagicalRecord

@objc(RepoCD)
public class RepoCD: _RepoCD {
	// Custom logic goes here.
    
    class func save(repos:[Repo]) {
        
        MagicalRecord.saveWithBlock { (context) in
            for repo in repos {
                
                var predicate = NSPredicate(format: "ownerId == %u", repo.repoOwner.ownerId)
                var repoOwnerCD = RepoOwnerCD.MR_findFirstWithPredicate(predicate, inContext: context)
                
                if repoOwnerCD == nil {
                    repoOwnerCD = RepoOwnerCD.MR_createEntityInContext(context)
                    repoOwnerCD?.ownerId = repo.repoOwner.ownerId
                    repoOwnerCD?.ownerName = repo.repoOwner.ownerName
                    repoOwnerCD?.ownerAvatar = repo.repoOwner.ownerAvatar?.absoluteString
                    
                } else {
                    //Pouco provavel de mudar o id.
                    repoOwnerCD?.ownerId = repo.repoOwner.ownerId
                    repoOwnerCD?.ownerName = repo.repoOwner.ownerName
                    repoOwnerCD?.ownerAvatar = repo.repoOwner.ownerAvatar?.absoluteString
                }
                
                predicate = NSPredicate(format: "repoId == %u", repo.repoId)
                var repoCD = self.MR_findFirstWithPredicate(predicate, inContext: context)
                
                if repoCD == nil {
                    repoCD = RepoCD.MR_createEntityInContext(context)
                    repoCD?.repoId = repo.repoId
                    repoCD?.repoName = repo.repoName
                    repoCD?.repoFullName = repo.repoFullName
                    repoCD?.repoUrl = repo.repoUrl.absoluteString
                    repoCD?.repoDesc = repo.repoDesc
                    repoCD?.repoForks = repo.repoForks
                    repoCD?.repoStars = repo.repoStars
                    repoCD?.repoIssues = repo.repoIssues
                    repoCD?.repoOwner = repoOwnerCD
                    
                } else {
                    repoCD?.repoId = repo.repoId
                    repoCD?.repoName = repo.repoName
                    repoCD?.repoFullName = repo.repoFullName
                    repoCD?.repoUrl = repo.repoUrl.absoluteString
                    repoCD?.repoDesc = repo.repoDesc
                    repoCD?.repoForks = repo.repoForks
                    repoCD?.repoStars = repo.repoStars
                    repoCD?.repoIssues = repo.repoIssues
                    repoCD?.repoOwner = repoOwnerCD
                }
            }
        }
    }
}
