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
    [self initializeWebView];
}

- (void)initializeWebView {
    self.webView = [[UIWebView alloc] initWithFrame:self.bounds];
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
    
    [self.webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:self.webView];
}

- (instancetype)init {
    self = [super init];
    [self initializeWebView];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initializeWebView];
    return self;
}

- (void)loadQuestion:(NSString *)questionId completion:(void(^)())completion {
    if (self.isLoading) {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        [self.webView loadHTMLString:@"<html><h1>Loading</h1></html>" baseURL:nil];
        [self.webView stopLoading];
        
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self performSelector:@selector(getHeight) withObject:nil afterDelay:0.5];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self getHeight];
}

- (void)getHeight {
    
    NSString *height = [self.webView stringByEvaluatingJavaScriptFromString:@"$('body').height()"];
    if ([height integerValue] != 0) {
        if (self.shouldSizeToFit) {
            CGRect rec = self.frame;
            rec.size.height = [height integerValue];
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
        else {
            CGRect rec = self.webView.frame;
            rec.size.height = [height integerValue];
            if (rec.size.height != self.frame.size.height) {
                self.webView.frame = rec;
                self.webView.center = self.center;
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
}

- (void)loadSet:(NSString *)setId completion:(void(^)())completion {
    NSString *bundlePath = [NSBundle mainBundle].bundleIdentifier;
    if (self.isLoading) {
        [self.webView stopLoading];
        [self.webView loadHTMLString:@"<html><h1>Loading</h1></html>" baseURL:nil];
    }
    self.isLoading = YES;
    if ([VPRequest sharedInstance].publisherId && ![[VPRequest sharedInstance].publisherId isEqualToString:@""]) {
        self.completion = completion;
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://voicepolls.com/widget/?type=set&id=%@&publisher=%@&frameId=1&url=%@", setId, [VPRequest sharedInstance].publisherId, bundlePath]]]];
    }
    else {
        [self.webView loadHTMLString:@"<html><h1>SET YOUR PUBLISHER ID</h1></html>" baseURL:nil];
    }
}



-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.isLoading = NO;
}

@end
