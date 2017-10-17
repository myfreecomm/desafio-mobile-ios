//
//  RequestBaseTests.m
//  Desafio Mobile iOSTests
//
//  Created by Adriano Rezena on 16/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RequestBase.h"

@interface RequestBaseTests : XCTestCase

@end

@implementation RequestBaseTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testHTTPMethod {
    NSString *expectedResult = @"GET";
    RequestBase *request = [[RequestBase alloc] initWithURL:@"www.url.com.br" httpMethod:expectedResult];
    XCTAssertTrue([request.HTTPMethod isEqualToString:expectedResult], @"HTTPMethod strings are not equal %@ %@", expectedResult, request.HTTPMethod);
}

- (void)testURL {
    NSString *expectedResult = @"www.url.com.br";
    RequestBase *request = [[RequestBase alloc] initWithURL:expectedResult httpMethod:@"GET"];
    XCTAssertEqual([request.URL absoluteString], expectedResult, @"URL strings are not equal %@ %@", expectedResult, [request.URL absoluteString]);
}

- (void)testHeaderFields {
    NSString *expectedResult = @"www.url.com.br";
    RequestBase *request = [[RequestBase alloc] initWithURL:expectedResult httpMethod:@"GET"];
    
    XCTAssertTrue([[[request allHTTPHeaderFields] allValues] containsObject:@"application/json"]);
}

@end
