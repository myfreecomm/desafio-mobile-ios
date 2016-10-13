//
//  PullRequestInfo.m
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import "PullRequestInfo.h"
#import <MTLModel.h>
#import <Mantle.h>
#import "PullRequestInfoJSON.h"

@implementation PullRequestInfo

+ (NSArray *)deserializePullRequestsInfosFromJSON:(NSArray *)pullRequestsInfoJSON {
    NSError *error;
    NSArray *pullRequestInfo = [MTLJSONAdapter modelsOfClass:[PullRequestInfoJSON class] fromJSONArray:pullRequestsInfoJSON error:&error];
    if (error) {
        return nil;
    }
    return pullRequestInfo;
}
@end
