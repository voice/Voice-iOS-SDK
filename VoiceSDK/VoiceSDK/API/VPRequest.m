//
//  VPRequest.m
//  VoiceSDK
//
//  Created by Alexandre barbier on 12/11/14.
//  Copyright (c) 2014 Poutsch. All rights reserved.
//

#import "VPRequest.h"

#define VP_BASE_URL @"https://api.voicepolls.com/1/"

@implementation VPRequest
Singleton(VPRequest);

+ (void)get:(NSString *)endPoint withParameters:(NSDictionary *)param success:(void(^)(NSData *response))success failure:(void(^)(NSError *error))failure {
    if ([VPRequest sharedInstance].publisherId && ![[VPRequest sharedInstance].publisherId isEqualToString:@""]) {
        NSURLSession *session = [NSURLSession sharedSession];
        session.configuration.HTTPAdditionalHeaders = @{@"client_id": @"voiceSdk"};
        NSString *str = [NSString stringWithFormat:@"%@%@",VP_BASE_URL, endPoint];
        if (param && param.count > 0) {
            str = [str stringByAppendingString:@"?"];
            for (NSString *key in param.allKeys) {
                str = [str stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key, param[key]]];
            }
        }
        [[session dataTaskWithURL:[NSURL URLWithString:str] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                success(data);
            }
            else {
                failure(error);
            }
        }] resume];
    }
    else {
        NSLog(@"VOICE SDK Error : Please specify your publisher id");
        failure(nil);
    }
    
}

+ (void)post:(NSString *)endPoint withParameter:(NSDictionary *)param success:(void(^)(NSData *response))success failure:(void(^)(NSError *error))failure {
    if ([VPRequest sharedInstance].publisherId && ![[VPRequest sharedInstance].publisherId isEqualToString:@""]) {
        NSURLSession *session = [NSURLSession sharedSession];
        session.configuration.HTTPAdditionalHeaders = @{@"client_id": @"voiceSdk"};
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",VP_BASE_URL, endPoint]]];
        request.HTTPMethod  = @"POST";
         [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                success(data);
            }
            else {
                failure(error);
            }
        }] resume];
    }
    else {
        NSLog(@"VOICE SDK Error : Please specify your publisher id");
        failure(nil);
    }
}

@end
