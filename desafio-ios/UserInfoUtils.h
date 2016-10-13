//
//  UserInfoUtils.h
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "Constants.h"

@interface UserInfoUtils : NSObject

+ (void)getFullNameOfUserFromPullRequest:(NSString *)userName completionBlock:(void(^)(NSString* response))completion;

@end
