//
//  VPQuestionView.h
//  VoiceSDK
//
//  Created by Alexandre barbier on 12/11/14.
//  Copyright (c) 2014 Poutsch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>


@interface VPQuestionView : UIView <WKNavigationDelegate, WKScriptMessageHandler>
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) void (^heightChange)(CGFloat height, VPQuestionView *question);
- (void)loadSet:(NSString *)setId;
- (void)loadQuestion:(NSString *)questionId completion:(void(^)())completion;
@end
