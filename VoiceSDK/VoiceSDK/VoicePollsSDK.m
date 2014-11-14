//
//  VoicePollsSDK.m
//  VoiceSDK
//
//  Created by Alexandre barbier on 12/11/14.
//  Copyright (c) 2014 Poutsch. All rights reserved.
//

#import "VoicePollsSDK.h"
#import "VPRequest.h"

@implementation VoicePollsSDK

Singleton(VoicePollsSDK)

-(void)setPublisherId:(NSString *)publisherId {
    _publisherId = publisherId;
    [VPRequest sharedInstance].publisherId = publisherId;

}

- (void)getMyQuestions:(void(^)(NSArray *questions))success failure:(void(^)(NSError *error))failure {
    NSString *bundlePath = [NSBundle mainBundle].bundleIdentifier;
    if (!bundlePath) {
        bundlePath = @"";
    }
    [VPRequest get:[NSString stringWithFormat:@"users/%@/questions", self.publisherId] withParameters:@{@"URL":bundlePath} success:^(NSData *response) {
        NSError *error = nil;
        NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
        NSArray *ret = resp[@"response"];
        success(ret);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)vote:(NSNumber *)vote onQuestion:(NSString *)questionId success:(void(^)(NSData *response))success failure:(void(^)(NSError *error))failure {
    NSString *bundlePath = [NSBundle mainBundle].bundleIdentifier;
    if (!bundlePath) {
        bundlePath = @"";
    }
    [VPRequest post:[NSString stringWithFormat:@"questions/%@/vote/%@",questionId, [vote stringValue]]
      withParameter:@{@"URL":bundlePath}
            success:^(NSData *response) {
                success(response);
    }
            failure:^(NSError *error) {
                failure(error);
    }];
}

- (void)getQuestionsInSet:(NSString *)setId success:(void(^)(NSArray *questions))success failure:(void(^)(NSError *error))failure {
    [VPRequest get:[NSString stringWithFormat:@"sets/%@", setId] withParameters:@{} success:^(NSData *response) {
        NSError *error = nil;
        NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
        NSDictionary *set = resp[@"response"];
        NSArray *questions = set[@"questions"];
        success(questions);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

- (void)getQuestionWithId:(NSString *)questionId success:(void(^)(NSDictionary *question))success failure:(void(^)(NSError *error))failure {
    [VPRequest get:[NSString stringWithFormat:@"questions/%@", questionId] withParameters:@{} success:^(NSData *response) {
        NSError *error = nil;
        NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
        NSDictionary *ret = resp[@"response"];
        success(ret);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)getQuestionsInTag:(NSString *)tagName success:(void(^)(NSDictionary *question))success failure:(void(^)(NSError *error))failure {
    [VPRequest get:[NSString stringWithFormat:@"tags/%@/questions", tagName] withParameters:@{} success:^(NSData *response) {
        NSError *error = nil;
        NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
        NSDictionary *ret = resp[@"response"];
        success(ret);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
