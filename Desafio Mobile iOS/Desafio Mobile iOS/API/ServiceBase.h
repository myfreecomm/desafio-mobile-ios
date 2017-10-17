//
//  ServiceBase.h
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 15/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface ServiceBase : NSObject

@property (strong, nonatomic) NSURLSessionDataTask *task;

- (void)retrieveDataWithSuccessHandler:(void(^)(void))successBlock andDidFailHandler:(void(^)(void))failBlock;
- (instancetype)initWithRequest:(RequestBase *)request;
- (void)parseJSON:(NSDictionary *)json;
- (BOOL)jsonIsValid:(NSDictionary *)json;

@end
