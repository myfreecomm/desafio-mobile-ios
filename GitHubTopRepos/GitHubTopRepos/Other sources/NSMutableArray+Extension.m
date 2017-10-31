//
//  NSMutableArray+Extension.m
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import "NSMutableArray+Extension.h"

@implementation NSMutableArray (GHRMutableArray)

-(void)replaceObjectsWithVariation:(id (^)(id object, NSUInteger index))newObjectForObject
{
    for (NSUInteger index = 0; index < self.count; index++)
    {
        id newObject = newObjectForObject([self objectAtIndex:index], index);
        [self replaceObjectAtIndex:index withObject:newObject ? newObject : [NSNull null]];
    }
}

@end
