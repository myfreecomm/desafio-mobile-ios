//
//  Repository.h
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 10/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>
#import "Owner.h"

@interface Repository : RLMObject

- (id)initWithDictionary:(NSDictionary*)dictionary;

@property NSString *name;
@property NSString *repDescription;
@property NSInteger forks_count;
@property NSInteger stargazers_count;
//@property (strong, nonatomic) Owner* owner;

@end
