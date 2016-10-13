//
//  UserInfoUtils.m
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import "UserInfoUtils.h"

@implementation UserInfoUtils

+ (void)getFullNameOfUserFromPullRequest:(NSString *)userName completionBlock:(void(^)(NSString* response))completion {
    
    __block NSString *fullName;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlWithParameters = @"https://api.github.com/users/";
    urlWithParameters = [urlWithParameters stringByAppendingString:userName];
    
    NSURL *URL = [NSURL URLWithString:urlWithParameters];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    __block NSDictionary *user;
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            
        }
        else {
            if (response) {
                NSError *error1;
                user = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error1];
                fullName = user[@"name"];
                
                if(![fullName isKindOfClass:[NSNull class]]) {
                    completion(fullName);
                }
            }
        }
    }];
    [dataTask resume];
}
@end
