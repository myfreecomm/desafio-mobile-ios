//
//  LibraryAPI.h
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 11/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>
#import "Repository.h"
#import "Constantes.h"


@interface LibraryAPI : NSObject

+(LibraryAPI *) sharedInstance;

-(void)getDados:(int)page;


@end
