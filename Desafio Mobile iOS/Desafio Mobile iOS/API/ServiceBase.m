//
//  ServiceBase.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 15/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "ServiceBase.h"

@implementation ServiceBase{
    RequestBase *localRequest;
}

-(instancetype)initWithRequest:(RequestBase *)request {
    self = [super init];
    
    if (self) {
        localRequest = request;
    }

    return self;
}


-(void)retrieveDataWithSuccessHandler:(void (^)(void))successBlock andDidFailHandler:(void (^)(void))failBlock {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

    self.task = [session dataTaskWithRequest:localRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];            
            
            if ([self jsonIsValid:json]) {
                [self parseJSON:json];
                successBlock();
            } else {
                NSLog(@"Retorno do JSON é inválido (%@)", json);
                failBlock();
            }
        } else {
            failBlock();
        }
    }];
                 
    [self.task resume];
}


-(void)parseJSON:(NSDictionary *)json {
    // abstract
}


-(BOOL)jsonIsValid:(NSDictionary *)json {
    return YES;
}

@end
