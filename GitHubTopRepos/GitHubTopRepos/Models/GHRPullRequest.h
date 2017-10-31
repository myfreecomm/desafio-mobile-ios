//
//  GHRPullRequest.h
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHRPullRequest : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* pullRequestDescription;

@property (nonatomic, strong) NSString* ownerPictureUrlPath;
@property (nonatomic, strong) NSString* ownerUsername;

@property (nonatomic, strong) NSString* creationDate;

+(GHRPullRequest*)pullRequestWithDictionary:(NSDictionary*)dict;

@end
