//
//  ActivityIndicatorViewBase.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 16/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "ActivityIndicatorViewBase.h"

@implementation ActivityIndicatorViewBase

-(instancetype)init {
    self = [super init];
    
    if (self) {
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        self.color = [UIColor grayColor];
        self.frame = CGRectMake(0, 0, 20, 20);
    }
    
    return self;
}

@end
