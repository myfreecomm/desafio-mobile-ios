//
//  RequestBase.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 15/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "RequestBase.h"

@implementation RequestBase

- (instancetype)initWithURL:(NSString *)urlString httpMethod:(NSString *)httpMethod {    
    NSURL *url = [NSURL URLWithString:urlString];
    
    self = [super initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:50];
    self.HTTPMethod = httpMethod;
    [self setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    return self;
}

@end
