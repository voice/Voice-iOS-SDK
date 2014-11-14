//
//  ViewController.m
//  VoiceSDKSample
//
//  Created by Alexandre barbier on 12/11/14.
//  Copyright (c) 2014 Poutsch. All rights reserved.
//

#import "ViewController.h"
#import <VoiceSDK/VoiceSDK.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet VPQuestionView *questView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //VPQuestionView *question = [[VPQuestionView alloc] initWithFrame:self.view.bounds];
    [self.questView loadSet:@"56"];
    [[VoicePollsSDK sharedInstance] getMyQuestions:^(NSArray *questions) {
        
    } failure:^(NSError *error) {
        
    }];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
