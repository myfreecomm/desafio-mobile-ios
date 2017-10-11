//
//  Repository.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 10/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "Repository.h"
#import <objc/runtime.h>

@implementation Repository


-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.name = dictionary[@"name"];
        self.repDescription = dictionary[@"description"];
        self.forks_count = [dictionary[@"forks_count"] integerValue];
        self.stargazers_count = [dictionary[@"stargazers_count"] integerValue];
    }

    return self;
}


@end
