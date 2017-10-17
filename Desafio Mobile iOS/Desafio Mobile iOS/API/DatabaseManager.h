//
//  DatabaseManager.h
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 15/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Repository.h"
#import "PullRequest.h"

@interface DatabaseManager : NSObject

+(DatabaseManager *) sharedInstance;

// Repository
-(void)createRepository: (NSDictionary *)jsonRepository jsonUser:(NSDictionary *)jsonUser;

// Pull request
-(void)createPullRequest: (NSDictionary *)jsonPullRequest jsonUser:(NSDictionary *)jsonUser updateString:(NSString *)updateString;
-(void)deletePullRequestsFromRepository:(NSInteger) repositoryId withUpdateString:(NSString *)updateString;

@end
