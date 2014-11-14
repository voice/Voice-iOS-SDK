//
//  VPQuestionView.m
//  VoiceSDK
//
//  Created by Alexandre barbier on 12/11/14.
//  Copyright (c) 2014 Poutsch. All rights reserved.
//

#import "VPQuestionView.h"
#import "VPRequest.h"

@interface VPQuestionView()

@property (nonatomic, strong) void (^completion)();

@end

@implementation VPQuestionView

- (void)awakeFromNib {
    [super awakeFromNib];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    WKUserScript *userS = [[WKUserScript alloc] initWithSource:@"window.top.postMessage = function(obj){ window.webkit.messageHandlers.top.postMessage(obj)}; window.webkit.messageHandlers.top.postMessage({test: \"te\"});" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [configuration.userContentController  addUserScript:userS];
    [configuration.userContentController addScriptMessageHandler:self name:@"top"];
    self.webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];
    self.webView.scrollView.bounces = NO;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:self.webView];
}

- (instancetype)init {
    self = [super init];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    WKUserScript *userS = [[WKUserScript alloc] initWithSource:@"window.top.postMessage = function(obj){ window.webkit.messageHandlers.top.postMessage(obj)}; window.webkit.messageHandlers.top.postMessage({test: \"te\"});" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [configuration.userContentController  addUserScript:userS];
    [configuration.userContentController addScriptMessageHandler:self name:@"top"];
    self.webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];
    self.webView.scrollView.bounces = NO;
    self.webView.navigationDelegate = self;
        self.webView.scrollView.scrollEnabled = NO;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:self.webView];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];

    WKUserScript *userS = [[WKUserScript alloc] initWithSource:@"window.top.postMessage = function(obj){ window.webkit.messageHandlers.top.postMessage(obj)}; window.top.postMessage({ plop: 'we', height: $('body').height()});" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    
    [configuration.userContentController addUserScript:userS];
    [configuration.userContentController addScriptMessageHandler:self name:@"top"];

    self.webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];
    self.webView.scrollView.bounces = NO;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    [self addSubview:self.webView];
    return self;
}

- (void)loadQuestion:(NSString *)questionId completion:(void(^)())completion {
    if (self.isLoading) {
        [self.webView stopLoading];
        [self.webView loadHTMLString:@"<html><h1>Loading</h1></html>" baseURL:nil];
    }
    self.isLoading = YES;
    if ([VPRequest sharedInstance].publisherId && ![[VPRequest sharedInstance].publisherId isEqualToString:@""]) {
        self.completion = completion;
        NSString *bundlePath = [NSBundle mainBundle].bundleIdentifier;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://voicepolls.com/widget/?type=question&id=%@&publisher=%@&frameId=1&url=%@", questionId, [VPRequest sharedInstance].publisherId, bundlePath]]]];
    }
    else {
        [self.webView loadHTMLString:@"<html><h1>SET YOUR PUBLISHER ID</h1></html>" baseURL:nil];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)loadSet:(NSString *)setId {
    NSString *bundlePath = [NSBundle mainBundle].bundleIdentifier;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://voicepolls.com/widget/?type=set&id=%@&publisher=%@&frameId=1&url=%@", setId, [VPRequest sharedInstance].publisherId, bundlePath]]]];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *body = message.body;

    if ([body[@"height"] integerValue] != 0) {
        CGRect rec = self.frame;
        rec.size.height = [body[@"height"] integerValue];
        if (rec.size.height != self.frame.size.height) {
            self.frame = rec;
            if (self.completion){
                self.height = rec.size.height;
                if (self.heightChange) {
                    self.heightChange(self.height, self);
                }

                self.completion();
            }
        }

    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.isLoading = NO;
}

@end
