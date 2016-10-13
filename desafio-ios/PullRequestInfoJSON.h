//
//  PullRequestInfoJSON.h
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <Mantle.h>

@interface PullRequestInfoJSON : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic, readwrite) NSString *nomePullRequest;
@property (strong, nonatomic, readwrite) NSString *descricacaoPullRequest;
@property (strong, nonatomic, readwrite) NSDictionary *usernamePullRequest;

@end
