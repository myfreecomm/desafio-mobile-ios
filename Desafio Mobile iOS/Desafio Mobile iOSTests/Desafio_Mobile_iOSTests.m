//
//  Desafio_Mobile_iOSTests.m
//  Desafio Mobile iOSTests
//
//  Created by Adriano Rezena on 10/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Repository.h"

@interface Desafio_Mobile_iOSTests : XCTestCase

@end

@implementation Desafio_Mobile_iOSTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    //Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "put any name here"
    
    /*Repository *repository = [Repository initWithDictionary:@{
                                                              @"id": @1,
                                                              @"state": @"open"
                                                              }];
    
    XCTAssertEqual(repository.id, 1, @"Falha ao carregar dado do ID");*/
}

/*
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
 */

@end
