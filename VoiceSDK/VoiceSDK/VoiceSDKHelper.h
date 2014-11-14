//
//  VoiceSDKHelper.h
//  VoiceSDK
//
//  Created by Alexandre barbier on 12/11/14.
//  Copyright (c) 2014 Poutsch. All rights reserved.
//

#ifndef VoiceSDK_VoiceSDKHelper_h
#define VoiceSDK_VoiceSDKHelper_h

#ifndef Singleton
#define Singleton(classname)                            \
\
+(classname *)sharedInstance {                     \
\
static dispatch_once_t pred;                            \
__strong static classname *sharedInstance = nil;   \
dispatch_once(&pred, ^{                                 \
sharedInstance = [[self alloc] init]; });          \
return sharedInstance;                             \
}

#endif

#endif
