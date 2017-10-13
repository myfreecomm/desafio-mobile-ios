//
//  PullRequest.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 12/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "PullRequest.h"

@implementation PullRequest

- (id)initWithDictionary:(NSDictionary*)dictionary andRepositoryId:(NSInteger)repositoryId {
    if (self = [super init]) {
        
        self.id = (long)dictionary[@"id"];
        self.repositoryId = repositoryId;
        self.url = dictionary[@"html_url"];
        self.state = dictionary[@"state"];
        self.title = dictionary[@"title"];
        self.body = dictionary[@"body"];
        
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
        self.created_at = [dateFormatter dateFromString:dictionary[@"created_at"]];
        
        self.owner = [[Owner alloc] initWithDictionary:dictionary[@"user"]];
    }
    
    return self;
}


+ (NSString *)primaryKey {
    return @"id";
}


@end
