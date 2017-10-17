//
//  Repository.h
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 10/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Owner.h"

@interface Repository : RLMObject

@property NSInteger id;
@property NSString *name;
@property NSString *repDescription;
@property NSInteger forks_count;
@property NSInteger stargazers_count;
@property NSString *pulls_url;
@property Owner* owner;

@end
