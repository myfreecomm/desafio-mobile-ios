//
//  LibraryAPI.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 11/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "LibraryAPI.h"

static NSString *const kRepositoriesPath = @"https://api.github.com/search/repositories?q=language:Java&sort=stars&page=";

@implementation LibraryAPI

+(LibraryAPI *) sharedInstance {
    static LibraryAPI *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LibraryAPI alloc] init];
    });
    
    return _sharedInstance;
}


-(void)getRepositories:(int)page {
    RequestBase *request = [[RequestBase alloc] initWithURL:[kRepositoriesPath stringByAppendingString:[NSString stringWithFormat:@"%i", page]] httpMethod:@"GET"];
    ServiceRepository *service = [[ServiceRepository alloc] initWithRequest:request];
    
    [service retrieveDataWithSuccessHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
           [[NSNotificationCenter defaultCenter] postNotificationName:kStrNotificationRepositoriesFinished object:self userInfo:nil];
        });
        
    } andDidFailHandler:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kStrNotificationRepositoriesError object:self userInfo:nil];
    }];
}


-(void)getPullRequestsfromRepository:(Repository *) repository {
    RequestBase *request = [[RequestBase alloc] initWithURL:repository.pulls_url httpMethod:@"GET"];
    ServicePullRequest *service = [[ServicePullRequest alloc] initWithRequest:request];
    
    [service retrieveDataWithSuccessHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kStrNotificationPullRequestFinished object:self userInfo:nil];
        });
        
    } andDidFailHandler:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kStrNotificationPullRequestError object:self userInfo:nil];
    }];
}


-(NSDictionary *)requestSynchronousJSONWithURLString:(NSString *)urlString {
    dispatch_semaphore_t semaphore;

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:10];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    __block NSMutableDictionary *resultMutableDictionary = [[NSMutableDictionary alloc] init];
    
    semaphore = dispatch_semaphore_create(0);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
        
        if (error) {
            NSLog(@"Erro no request: %@", error);
        } else {
            resultMutableDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        }
        
      dispatch_semaphore_signal(semaphore);
    }];
    
    [task resume];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    return resultMutableDictionary;
}


@end
