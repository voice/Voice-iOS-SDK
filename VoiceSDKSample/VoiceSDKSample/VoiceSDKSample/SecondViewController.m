//
//  SecondViewController.m
//  VoiceSDKSample
//
//  Created by Alexandre barbier on 12/11/14.
//  Copyright (c) 2014 Poutsch. All rights reserved.
//

#import "SecondViewController.h"
#import <VoiceSDK/VoiceSDK.h>
#import "VPCell.h"

@interface SecondViewController ()
@property (nonatomic, strong) NSArray *displayeDataSource;
@property (nonatomic, strong) NSMutableArray *web;
@property (nonatomic, strong) NSMutableArray *cellSize;
@property (nonatomic, strong) NSMutableArray *questionsId;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[VoicePollsSDK sharedInstance] getMyQuestions:^(NSArray *questions) {
        self.displayeDataSource = questions;
        self.cellSize = [NSMutableArray arrayWithCapacity:questions.count];
        self.questionsId = [NSMutableArray arrayWithCapacity:questions.count];
        for (int i = 0; i < questions.count; i++) {
            [self.cellSize addObject:[NSNumber numberWithFloat:568.0]];
            [self.questionsId addObject:questions[i][@"id"]];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
        
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.displayeDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 480.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VPCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.questionId = [self.displayeDataSource[indexPath.row][@"id"] stringValue];


    [cell.questionView loadQuestion:cell.questionId completion:^{

    }];
    
    return cell;
}


@end
