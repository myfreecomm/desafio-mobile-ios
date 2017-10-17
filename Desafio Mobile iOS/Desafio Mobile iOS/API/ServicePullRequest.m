//
//  ServicePullRequest.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 16/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "ServicePullRequest.h"

@implementation ServicePullRequest

-(void)parseJSON:(NSDictionary *)json {
    NSArray *array = [json copy];
    
    NSString *updateString = [[NSUUID UUID] UUIDString];
    
    for (NSDictionary *dictionary in array) {
        NSDictionary *owner = dictionary[@"user"];
        NSDictionary *userJSON = [[LibraryAPI sharedInstance] requestSynchronousJSONWithURLString:owner[@"url"]];
        [[DatabaseManager sharedInstance] createPullRequest:dictionary jsonUser:userJSON updateString:updateString];
    }
    
    NSDictionary *repo = array[0][@"base"][@"repo"];
    NSInteger repositoryId = [repo[@"id"] integerValue];
    
    [[DatabaseManager sharedInstance] deletePullRequestsFromRepository:repositoryId withUpdateString:updateString];
}

-(BOOL)jsonIsValid:(NSDictionary *)json {
    if (json) {
        if ([json count] > 0) {
            if ([json isKindOfClass:[NSArray class]]) {
                NSArray *array = [json copy];
                return [[array[0] allKeys] containsObject:@"url"];
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

@end
