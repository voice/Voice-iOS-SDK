//
//  VPQuestionView.h
//  VoiceSDK
//
//  Created by Alexandre barbier on 12/11/14.
//  Copyright (c) 2014 Poutsch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface VPQuestionView : UIView <UIWebViewDelegate>
/**
 * @property isLoading
 * Boolean value indicating if the webview is loading
 */
@property (nonatomic, assign) BOOL isLoading;
/**
 * @property webView
 * the WKWebView
 */
@property (nonatomic, strong) UIWebView *webView;
/**
 * @property shouldSizeToFit specified if the view should resize when the webview is loaded to fit.
 *
 */
@property (nonatomic, assign) BOOL shouldSizeToFit;

/**
 * @property height
 *
 */
@property (nonatomic, assign) CGFloat height;

/**
 * @property
 * this bloc is called after the VPQuestionView resized
 */
@property (nonatomic, strong) void (^heightChange)(CGFloat height, VPQuestionView *question);

/**
 * @method loadSet
 * @param setId
 * Load a set identified by its ID
 */
- (void)loadSet:(NSString *)setId completion:(void(^)())completion;

/**
 * load the question identified by is id in the webview
 */
- (void)loadQuestion:(NSString *)questionId completion:(void(^)())completion;

@end
