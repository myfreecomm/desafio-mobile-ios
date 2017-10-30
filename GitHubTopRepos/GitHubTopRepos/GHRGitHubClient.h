//
//  GHRGitHubClient.h
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHRGitHubClient : NSObject

+(void)gitHubTopRepositories:(void (^) (NSArray* list, NSString* error))completionHandler;

@end
