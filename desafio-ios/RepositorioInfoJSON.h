//
//  RepositorioInfoJSON.h
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MTLModel.h>
#import <Mantle.h>

@interface RepositorioInfoJSON : MTLModel<MTLJSONSerializing>

@property (strong, nonatomic, readwrite) NSString *nomeRepositorio;
@property (strong, nonatomic, readwrite) NSString *descricacaoRepositorio;
@property (strong, nonatomic, readwrite) NSDictionary *usernameOwnerRepositorio;
@property (strong, nonatomic, readwrite) NSString *nomeSobrenomeOwnerRepositorio;
@property (strong, nonatomic, readwrite) NSNumber *numeroForksRepositorio;
@property (strong, nonatomic, readwrite) NSNumber *numeroWatchesRepositorio;

@end
