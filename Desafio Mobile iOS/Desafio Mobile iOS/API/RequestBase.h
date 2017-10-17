//
//  RequestBase.h
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 15/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestBase : NSMutableURLRequest

- (instancetype)initWithURL:(NSString *)urlString httpMethod:(NSString *)httpMethod;

@end
