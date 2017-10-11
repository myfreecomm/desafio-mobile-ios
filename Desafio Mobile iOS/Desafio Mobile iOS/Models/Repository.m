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
        self.forks_count = dictionary[@"forks_count"];
        self.stargazers_count = dictionary[@"stargazers_count"];
    }
    
    NSMutableArray *propertyKeys = [NSMutableArray array];
    Class currentClass = self.class;
    
    while ([currentClass superclass]) { // avoid printing NSObject's attributes
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(currentClass, &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char *propName = property_getName(property);
            if (propName) {
                NSString *propertyName = [NSString stringWithUTF8String:propName];
                [propertyKeys addObject:propertyName];
            }
        }
        free(properties);
        currentClass = [currentClass superclass];
    }
    
    return self;
}


+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name": @"name",
             @"repDescription": @"description",
             @"forks": @"forks_count",
             @"stars": @"stargazers_count",
             @"username": @"login",
             @"avatar": @"avatar_url"
             };
}


@end
