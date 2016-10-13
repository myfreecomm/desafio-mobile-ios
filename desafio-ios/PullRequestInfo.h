//
//  PullRequestInfo.h
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PullRequestInfo : NSObject

+ (NSArray *)deserializePullRequestsInfosFromJSON:(NSArray *)pullRequestsInfoJSON;

@property (strong, nonatomic, readwrite) NSString *nomePullRequest;
@property (strong, nonatomic, readwrite) NSString *descricacaoPullRequest;
@property (strong, nonatomic, readwrite) NSDictionary *usernamePullRequest;

@end
