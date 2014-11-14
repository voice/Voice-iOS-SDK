//
//  VPRequest.h
//  VoiceSDK
//
//  Created by Alexandre barbier on 12/11/14.
//  Copyright (c) 2014 Poutsch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VoiceSDKHelper.h"

@interface VPRequest : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong) NSString *publisherId;


+ (void)get:(NSString *)endPoint withParameters:(NSDictionary *)param success:(void(^)(NSData *response))success failure:(void(^)(NSError *error))failure;

+ (void)post:(NSString *)endPoint withParameter:(NSDictionary *)param success:(void(^)(NSData *response))success failure:(void(^)(NSError *error))failure;

@end
