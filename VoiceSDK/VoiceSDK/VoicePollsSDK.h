//
//  VoicePollsSDK.h
//  VoiceSDK
//
//  Created by Alexandre barbier on 12/11/14.
//  Copyright (c) 2014 Poutsch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoicePollsSDK : NSObject
+ (instancetype) sharedInstance;
@property (nonatomic, strong) NSString *publisherId;

- (void)getMyQuestions:(void(^)(NSArray *questions))success failure:(void(^)(NSError *error))failure;

- (void)getQuestionsInSet:(NSString *)setId success:(void(^)(NSArray *questions))success failure:(void(^)(NSError *error))failure;

- (void)getQuestionWithId:(NSString *)questionId success:(void(^)(NSDictionary *question))success failure:(void(^)(NSError *error))failure;
- (void)vote:(NSNumber *)vote onQuestion:(NSString *)questionId success:(void(^)(NSData *response))success failure:(void(^)(NSError *error))failure;
@end
