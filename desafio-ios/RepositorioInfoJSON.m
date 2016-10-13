//
//  RepositorioInfoJSON.m
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import "RepositorioInfoJSON.h"
#import "RepositorioInfo.h"

@implementation RepositorioInfoJSON

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"nomeRepositorio" : @"name",
        @"descricacaoRepositorio" : @"description",
        @"usernameOwnerRepositorio" : @"owner",
        @"nomeSobrenomeOwnerRepositorio" : @"full_name",
        @"numeroForksRepositorio" : @"forks",
        @"numeroWatchesRepositorio" : @"stargazers_count"
    };
}
@end
