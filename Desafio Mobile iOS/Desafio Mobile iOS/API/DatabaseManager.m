//
//  DatabaseManager.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 15/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

+(DatabaseManager *) sharedInstance {
    static DatabaseManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DatabaseManager alloc] init];
    });
    
    return _sharedInstance;
}


-(void)createRepository: (NSDictionary *)jsonRepository jsonUser:(NSDictionary *)jsonUser {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    Repository *repository = [Repository new];
    repository.id = [jsonRepository[@"id"] integerValue];
    repository.name = jsonRepository[@"name"];
    repository.repDescription = jsonRepository[@"description"];
    repository.forks_count = [jsonRepository[@"forks_count"] integerValue];
    repository.stargazers_count = [jsonRepository[@"stargazers_count"] integerValue];
    repository.pulls_url = [jsonRepository[@"pulls_url"] stringByReplacingOccurrencesOfString:@"{/number}" withString:@""];
    
    repository.owner = [self createOwner:jsonUser];
    
    if ([[jsonUser allKeys] containsObject:@"name"]) {
        repository.owner.name = jsonUser[@"name"];
    }
        
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:repository];
    [realm commitWriteTransaction];
}


-(Owner *)createOwner:(NSDictionary *)jsonOwner {
    Owner *owner = [Owner new];
    
    owner.login = jsonOwner[@"login"];
    owner.avatar_url = jsonOwner[@"avatar_url"];
    owner.url = jsonOwner[@"url"];
    
    return owner;
}


-(void)createPullRequest: (NSDictionary *)jsonPullRequest jsonUser:(NSDictionary *)jsonUser updateString:(NSString *)updateString {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    PullRequest *pullRequest = [PullRequest new];
    
    NSDictionary *repo = jsonPullRequest[@"base"][@"repo"];
    pullRequest.repositoryId = [repo[@"id"] integerValue];
    
    pullRequest.id = [jsonPullRequest[@"id"] integerValue];
    pullRequest.url = jsonPullRequest[@"html_url"];
    pullRequest.state = jsonPullRequest[@"state"];
    pullRequest.title = jsonPullRequest[@"title"];
    pullRequest.body = jsonPullRequest[@"body"];
    pullRequest.updateString = updateString;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    pullRequest.created_at = [dateFormatter dateFromString:jsonPullRequest[@"created_at"]];
    
    pullRequest.owner = [self createOwner:jsonUser];
    
    if ([[jsonUser allKeys] containsObject:@"name"]) {
        pullRequest.owner.name = jsonUser[@"name"];
    }
    
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:pullRequest];
    [realm commitWriteTransaction];
}

-(void)deletePullRequestsFromRepository:(NSInteger)repositoryId withUpdateString:(NSString *)updateString {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    RLMResults<PullRequest *> *pullRequests = [PullRequest objectsWhere:@"repositoryId = %i", repositoryId];
    
    for (PullRequest *pullRequest in pullRequests) {
        if (![pullRequest.updateString isEqualToString:updateString]) {
            [realm beginWriteTransaction];
            [realm deleteObject:pullRequest];
            [realm commitWriteTransaction];
        }
    }
}

@end
