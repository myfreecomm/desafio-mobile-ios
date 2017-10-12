//
//  Owner.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 10/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "Owner.h"

@implementation Owner

-(id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.login = dictionary[@"login"];
        self.avatar_url = dictionary[@"avatar_url"];
    }
    
    return self;
}

@end
