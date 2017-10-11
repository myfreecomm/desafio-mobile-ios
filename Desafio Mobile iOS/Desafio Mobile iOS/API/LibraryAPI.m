//
//  LibraryAPI.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 11/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "LibraryAPI.h"
#import "Repository.h"

static NSString *const kRepositoriesPath = @"https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1";

@implementation LibraryAPI

+(LibraryAPI *) sharedInstance {
    static LibraryAPI *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LibraryAPI alloc] init];
    });
    
    return _sharedInstance;
}

-(void)getDados {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

    NSURL *url = [NSURL URLWithString:kRepositoriesPath];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    //NSMutableArray *dados = [NSMutableArray new];
    
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
                
                /*RLMResults<Repository *> *repository = [Repository allObjects];
                
                 [realm transactionWithBlock:^{                     
                     for (Repository *repo in repository) {
                         [realm deleteObject:repo];
                     }
                 }];*/
                
                
                for (int i = 0; i < [repositorios count] - 1; i++) {
                    Repository *repositorio = [[Repository alloc] initWithDictionary:repositorios[i]];
             
                    [realm beginWriteTransaction];
                    [realm addObject:repositorio];
                    [realm commitWriteTransaction];
                    
                }
            }
        }
        
    }];
    
    [downloadTask resume];
}

@end
