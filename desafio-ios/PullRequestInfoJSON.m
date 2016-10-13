//
//  PullRequestInfoJSON.m
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import "PullRequestInfoJSON.h"

@implementation PullRequestInfoJSON

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
         @"nomePullRequest" : @"title",
         @"descricacaoPullRequest" : @"body",
         @"usernamePullRequest" : @"user",
         };
}

@end
