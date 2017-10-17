//
//  ServiceRepositoryTests.m
//  Desafio Mobile iOSTests
//
//  Created by Adriano Rezena on 16/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ServiceRepository.h"

@interface ServiceRepositoryTests : XCTestCase

@end

@implementation ServiceRepositoryTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testJsonIsValid {
    ServiceRepository *serviceRepository = [ServiceRepository new];
    
    NSMutableDictionary *testDictionary = [NSMutableDictionary new];
    [testDictionary setValue:@"3738268" forKey:@"total_count"];
    [testDictionary setValue:[NSNumber numberWithBool:false] forKey:@"incomplete_results"];
    
    NSMutableDictionary *testItemsDictionary = [NSMutableDictionary new];
    [testItemsDictionary setValue:@7508411 forKey:@"id"];
    [testItemsDictionary setValue:@"RxJava" forKey:@"name"];
    [testItemsDictionary setValue:@"ReactiveX/RxJava" forKey:@"full_name"];
    
    [testDictionary setValue:testItemsDictionary forKey:@"items"];
    [testDictionary setValue:@"https://api.github.com/repos/ReactiveX/RxJava" forKey:@"url"];
    [serviceRepository jsonIsValid:testDictionary];
    
    XCTAssertTrue([serviceRepository jsonIsValid:testDictionary], @"JSON is invalid");
}

- (void)testJsonIsInvalid {
    ServiceRepository *serviceRepository = [ServiceRepository new];
    
    NSMutableDictionary *testDictionary = [NSMutableDictionary new];
    [testDictionary setValue:@"3738268" forKey:@"total_count"];
    [testDictionary setValue:[NSNumber numberWithBool:false] forKey:@"incomplete_results"];
    
    [testDictionary setValue:@"https://api.github.com/repos/ReactiveX/RxJava" forKey:@"url"];
    [serviceRepository jsonIsValid:testDictionary];
    
    XCTAssertFalse([serviceRepository jsonIsValid:testDictionary]);
}



@end
