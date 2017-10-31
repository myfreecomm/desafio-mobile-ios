//
//  GHRRepository.m
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import "GHRRepository.h"

@implementation GHRRepository

+(GHRRepository*)repositoryWithDictionary:(NSDictionary*)dict
{
    GHRRepository* repo = [[GHRRepository alloc] init];
    
    repo.name = dict[@"name"];
    repo.repositoryDescription = dict[@"description"];
    
    repo.forkCounter = [dict[@"forks_count"] intValue];
    repo.starCounter = [dict[@"stargazers_count"] intValue];
    
    repo.ownerUsername = dict[@"owner"][@"login"];
    repo.ownerPictureUrlPath = dict[@"owner"][@"avatar_url"];
    
    return repo;
}

@end
