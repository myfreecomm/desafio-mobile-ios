import Foundation
import MagicalRecord

@objc(PullsCD)
public class PullsCD: _PullsCD {
	// Custom logic goes here.
    
    class func save(pulls:[Pulls]) {
        
        MagicalRecord.saveWithBlock { (context) in
            for pull in pulls {
                
                var predicate = NSPredicate(format: "userId == %u", pull.pullUser.userId)
                var pullUserCD = PullsUserCD.MR_findFirstWithPredicate(predicate, inContext: context)
                
                if pullUserCD == nil {
                    pullUserCD = PullsUserCD.MR_createEntityInContext(context)
                    pullUserCD?.userId = pull.pullUser.userId
                    pullUserCD?.userName = pull.pullUser.userName
                    pullUserCD?.userAvatar = pull.pullUser.userAvatar?.absoluteString
                    
                } else {
                    //Pouco provavel de mudar o id.
                    pullUserCD?.userId = pull.pullUser.userId
                    pullUserCD?.userName = pull.pullUser.userName
                    pullUserCD?.userAvatar = pull.pullUser.userAvatar?.absoluteString
                }
                
                predicate = NSPredicate(format: "pullId == %u", pull.pullId)
                var pullCD = self.MR_findFirstWithPredicate(predicate, inContext: context)
                
                if pullCD == nil {
                    pullCD = PullsCD.MR_createEntityInContext(context)
                    pullCD?.pullId = pull.pullId
                    pullCD?.pullUrl = pull.pullUrl.absoluteString
                    pullCD?.pullBody = pull.pullBody
                    pullCD?.pullDate = pull.pullDate
                    pullCD?.pullTitle = pull.pullTitle
                    pullCD?.pullUser = pullUserCD
                    
                } else {
                    pullCD?.pullId = pull.pullId
                    pullCD?.pullUrl = pull.pullUrl.absoluteString
                    pullCD?.pullBody = pull.pullBody
                    pullCD?.pullDate = pull.pullDate
                    pullCD?.pullTitle = pull.pullTitle
                    pullCD?.pullUser = pullUserCD
                }
            }
        }
    }
}
