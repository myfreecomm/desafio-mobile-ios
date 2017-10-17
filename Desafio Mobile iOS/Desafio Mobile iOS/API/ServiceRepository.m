//
//  ServiceRepository.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 15/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "ServiceRepository.h"

@implementation ServiceRepository

-(void)parseJSON:(NSDictionary *)json {
    NSArray *array = json[@"items"];
    
    for (NSDictionary *dictionary in array) {
        
        NSDictionary *owner = dictionary[@"owner"];
        NSDictionary *userJSON = [[LibraryAPI sharedInstance] requestSynchronousJSONWithURLString:owner[@"url"]];
        
        [[DatabaseManager sharedInstance] createRepository:dictionary jsonUser:userJSON];
    }
}


-(BOOL)jsonIsValid:(NSDictionary *)json {
    if (json) {
        return [[json allKeys] containsObject:@"items"];
    } else {
        return NO;
    }
}

@end
