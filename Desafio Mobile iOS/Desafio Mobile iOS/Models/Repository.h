//
//  Repository.h
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 10/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Owner.h"

@interface Repository : NSObject

- (id)initWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *repDescription;
@property (nonatomic, copy) NSString *forks_count;
@property (nonatomic, copy) NSString *stargazers_count;
@property (strong, nonatomic) Owner* owner;

@end
