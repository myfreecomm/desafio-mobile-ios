//
//  RepositorioInfo.m
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import "RepositorioInfo.h"
#import <MTLModel.h>
#import <Mantle.h>
#import "RepositorioInfoJSON.h"

@implementation RepositorioInfo

+ (NSArray *)deserializeReposInfosFromJSON:(NSArray *)repositorionInfoJSON {
    NSError *error;
    NSArray *reposInfo = [MTLJSONAdapter modelsOfClass:[RepositorioInfoJSON class] fromJSONArray:repositorionInfoJSON error:&error];
    if (error) {
        return nil;
    }
    return reposInfo;
}

@end
