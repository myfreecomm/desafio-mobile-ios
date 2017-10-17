//
//  LibraryAPI.h
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 11/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>
#import "DatabaseManager.h"
#import "Repository.h"
#import "PullRequest.h"
#import "Constantes.h"
#import "RequestBase.h"
#import "ServiceRepository.h"
#import "ServicePullRequest.h"

@interface LibraryAPI : NSObject

+(LibraryAPI *) sharedInstance;

-(void)getRepositories:(int)page;
-(void)getPullRequestsfromRepository:(Repository *) repository;
-(NSDictionary *)requestSynchronousJSONWithURLString:(NSString *)urlString;

@end
