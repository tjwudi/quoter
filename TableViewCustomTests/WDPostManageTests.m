//
//  WDPostManageTests.m
//  TableViewCustom
//
//  Created by Wu Di on 11/16/14.
//  Copyright (c) 2014 Alibaba Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "WDPostManager.h"
#import "WDPost.h"

@interface WDPostManageTests : XCTestCase
@property (nonatomic) WDPostManager *postManager;
@end

@implementation WDPostManageTests

- (void)setUp {
    [super setUp];
    self.postManager = [WDPostManager sharedManager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDownloadPostsWithCompletion {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Wait for download"];
    
    [self.postManager downloadPostsWithCompletion:^(NSArray *posts) {
        XCTAssertEqual(posts.count, 4);
        XCTAssert([posts[0] isKindOfClass:[WDPost class]]);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
