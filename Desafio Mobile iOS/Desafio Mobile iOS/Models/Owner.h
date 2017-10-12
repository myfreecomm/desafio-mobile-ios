//
//  Owner.h
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 10/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RLMObject.h>

@interface Owner : RLMObject

- (id)initWithDictionary:(NSDictionary*)dictionary;

@property NSString *login;
@property NSString *avatar_url;

@end
