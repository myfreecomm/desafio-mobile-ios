//
//  GHRGitHubClient.m
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "GHRGitHubClient.h"

@implementation GHRGitHubClient

+(void)gitHubTopRepositories:(void (^) (NSArray* list, NSString* error))completionHandler
{
    NSString *githubApiUrlPath = @"https://api.github.com/search/repositories";
    NSDictionary* parameters = @{@"q": @"language:Java", @"sort": @"stars", @"page": @"1"};
    
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:githubApiUrlPath
                                                                         parameters:parameters error:nil];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:
                                      ^(NSURLResponse *response, id responseObject, NSError *error)
    {
        if (error)
        {
            completionHandler(nil, [error localizedDescription]);
        }
        else
        {
            completionHandler(responseObject, nil);
        }
    }];
    
    [dataTask resume];
}

@end
