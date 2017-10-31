//
//  GHRPullRequest.m
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import "GHRPullRequest.h"

@implementation GHRPullRequest

+(NSString*)regularDateStringWithGithubDateString:(NSString*)dateString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSDate* date = [formatter dateFromString:dateString];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    return [formatter stringFromDate:date];
}

+(GHRPullRequest*)pullRequestWithDictionary:(NSDictionary*)dict
{
    GHRPullRequest* pull = [[GHRPullRequest alloc] init];
    
    pull.name = dict[@"title"];
    pull.pullRequestDescription = [dict[@"body"] isKindOfClass:[NSString class]] ? dict[@"body"] : @"";
    
    pull.ownerUsername = dict[@"user"][@"login"];
    pull.ownerPictureUrlPath = dict[@"user"][@"avatar_url"];
    
    pull.creationDate = [self regularDateStringWithGithubDateString:dict[@"created_at"]];
    
    return pull;
}

@end
