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
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

    NSURL *url = [NSURL URLWithString:[kRepositoriesPath stringByAppendingString:[NSString stringWithFormat:@"%i", page]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask *downloadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            if (httpResp.statusCode == 200) {
                NSDictionary* json = [NSJSONSerialization
                                      JSONObjectWithData:data
                                      options:kNilOptions
                                      error:&error];
                
                NSArray *repositorios = json[@"items"];
                
                RLMRealm *realm = [RLMRealm defaultRealm];

                for (int i = 0; i < [repositorios count]; i++) {
                    Repository *repositorio = [[Repository alloc] initWithDictionary:repositorios[i]];
                    
                    NSDictionary *retorno = [self requestSynchronousJSONWithURLString:repositorio.owner.url];
                    
                    if ([[retorno allKeys] containsObject:@"name"]) {
                        repositorio.owner.name = retorno[@"name"];
                    }
                    
                    [realm beginWriteTransaction];
                    [realm addOrUpdateObject:repositorio];
                    [realm commitWriteTransaction];
                }
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kStrNotificationRepositoriesFinished object:self userInfo:nil];
                });
            } else {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kStrNotificationRepositoriesError object:self userInfo:@{@"mensagem":httpResp.description}];
                });
            }
        }
        
    }];
    
    [downloadTask resume];
}


-(void)getPullRequestsfromRepository:(Repository *) repository {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:repository.pulls_url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSInteger repositoryId = repository.id;
    
    NSURLSessionDataTask *downloadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
            if (httpResp.statusCode == 200) {
                NSDictionary* json = [NSJSONSerialization
                                      JSONObjectWithData:data
                                      options:kNilOptions
                                      error:&error];
                
                NSArray *pullRequestsArray = [json copy];
                
                RLMRealm *realm = [RLMRealm defaultRealm];
                
                for (int i = 0; i < [pullRequestsArray count]; i++) {
                    PullRequest *pullRequest = [[PullRequest alloc] initWithDictionary:pullRequestsArray[i] andRepositoryId:repositoryId];

                    NSDictionary *retorno = [self requestSynchronousJSONWithURLString:pullRequest.owner.url];
                    
                    if ([retorno count] > 0) {
                        pullRequest.owner.name = retorno[@"name"];
                    }
                    
                    [realm beginWriteTransaction];
                    [realm addOrUpdateObject:pullRequest];
                    [realm commitWriteTransaction];
                }
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kStrNotificationPullRequestFinished object:self userInfo:nil];
                });
            } else {
                // Pode cair aqui se exceder o limite de consultas requeridas, sem autenticação
                NSLog(@"Retorno não esperado ao carregar pull requests: %@", httpResp);
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kStrNotificationPullRequestError object:self userInfo:@{@"mensagem":httpResp.description}];
                });
            }
        } else {
            NSLog(@"Erro ao carregar pull requests: %@", error);
        }
    }];
    
    [downloadTask resume];
}

-(NSDictionary *)requestSynchronousJSONWithURLString:(NSString *)requestString {
    
    dispatch_semaphore_t semaphore;

    NSURL *url = [NSURL URLWithString:requestString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:50];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    __block NSMutableDictionary *resultMutableDictionary = [[NSMutableDictionary alloc] init];
    
    semaphore = dispatch_semaphore_create(0);
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error)
                                  {
                                      resultMutableDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                      
                                      dispatch_semaphore_signal(semaphore);
                                  }];
    
    [task resume];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    return resultMutableDictionary;
}


@end
