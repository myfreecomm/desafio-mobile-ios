//
//  GHRGitHubClient.m
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFImageDownloader.h>
#import "GHRGitHubClient.h"

static const NSString* GITHUB_REPOSITORIES_API_OUTPUT_ITEMS_KEY = @"items";

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
            completionHandler([(NSDictionary*)responseObject objectForKey:GITHUB_REPOSITORIES_API_OUTPUT_ITEMS_KEY], nil);
        }
    }];
    
    [dataTask resume];
}

+(void)gitHubPullRequestsFromUser:(NSString*)user fromRepository:(NSString*)repository withCompletionHandler:(void (^) (NSArray* list, NSString* error))completionHandler
{
    NSString *githubApiUrlPath = [NSString stringWithFormat:@"https://api.github.com/repos/%@/%@/pulls",user,repository];
    NSDictionary* parameters = @{@"state": @"all"};
    
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

+(void)githubUserPictureFromUrlPath:(NSString*)urlPath withCompletionHandler:(void (^) (UIImage* picture, NSString* error))completionHandler
{
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlPath
                                                                         parameters:nil error:nil];
    
    [[AFImageDownloader defaultInstance] downloadImageForURLRequest:request success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject)
    {
        completionHandler(responseObject, nil);
    }
    failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error)
    {
        completionHandler(nil, [error localizedDescription]);
    }];
}

@end
