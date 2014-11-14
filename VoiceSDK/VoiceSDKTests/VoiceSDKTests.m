//
//  VoiceSDKTests.m
//  VoiceSDKTests
//
//  Created by Alexandre barbier on 12/11/14.
//  Copyright (c) 2014 Poutsch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VoiceSDK.h"

@interface VoiceSDKTests : XCTestCase

@end

@implementation VoiceSDKTests

- (void)setUp {
    [super setUp];
    [VoicePollsSDK sharedInstance].publisherId = @"3";

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testQuestionsForUser {

    __block BOOL canPass  = false;
    [[VoicePollsSDK sharedInstance] getMyQuestions:^(NSArray *questions) {
        XCTAssert(questions.count > 0);
        canPass = YES;
    } failure:^(NSError *error) {
        XCTAssert(NO);
        canPass = YES;
    }];
    while (!canPass) {
        
    }
}


- (void)testVoteOnQuestion {
    
    __block BOOL canPass  = false;
    
    [[VoicePollsSDK sharedInstance] getQuestionWithId:@"3" success:^(NSDictionary *question) {

        [[VoicePollsSDK sharedInstance] vote:@1 onQuestion:@"3" success:^(NSData *response) {
            XCTAssert(YES);
            canPass = YES;
        } failure:^(NSError *error) {
            XCTAssert(NO);
        }];

    } failure:^(NSError *error) {
        XCTAssert(NO);
        canPass = YES;
    }];
    while (!canPass) {
        
    }
}


- (void)testQuestionById {
    __block BOOL canPass  = false;
    [[VoicePollsSDK sharedInstance] getQuestionWithId:@"3" success:^(NSDictionary *question) {
        XCTAssert([question[@"id"] integerValue] == 3);
        canPass = YES;
    } failure:^(NSError *error) {
        XCTAssert(NO);
        canPass = YES;
    }];
    while (!canPass) {
        
    }
}


- (void)testQuestionInTag {
    __block BOOL canPass  = false;
    [[VoicePollsSDK sharedInstance] getQuestionsInTag:@"voice" success:^(NSDictionary *question) {
        XCTAssert(YES);
        canPass = YES;
    } failure:^(NSError *error) {
        XCTAssert(NO);
        canPass = YES;
    }];
    while (!canPass) {
        
    }
}


- (void)testSet {
    __block BOOL canPass  = false;
    [[VoicePollsSDK sharedInstance] getQuestionsInSet:@"54" success:^(NSArray *questions) {
        XCTAssert([questions[0][@"id"] integerValue] == 1207721);
        canPass = YES;
    } failure:^(NSError *error) {
        XCTAssert(NO);
        canPass = YES;
    }];
    while (!canPass) {
        
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
