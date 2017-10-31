//
//  GHRRepository.h
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHRRepository : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* repositoryDescription;

@property (nonatomic) NSUInteger forkCounter;
@property (nonatomic) NSUInteger starCounter;

@property (nonatomic, strong) NSString* ownerPictureUrlPath;
@property (nonatomic, strong) NSString* ownerUsername;

+(GHRRepository*)repositoryWithDictionary:(NSDictionary*)dict;

@end
