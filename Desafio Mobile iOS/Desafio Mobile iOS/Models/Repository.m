//
//  Repository.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 10/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "Repository.h"

@implementation Repository

-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.id = [dictionary[@"id"] integerValue];
        self.name = dictionary[@"name"];
        self.repDescription = dictionary[@"description"];
        self.forks_count = [dictionary[@"forks_count"] integerValue];
        self.stargazers_count = [dictionary[@"stargazers_count"] integerValue];
        self.pulls_url = [dictionary[@"pulls_url"] stringByReplacingOccurrencesOfString:@"{/number}" withString:@""];
        
        self.owner = [[Owner alloc] initWithDictionary:dictionary[@"owner"]];
    }

    return self;
}


+ (NSString *)primaryKey {
    return @"id";
}


@end
