//
//  VPCell.h
//  VoiceSDKSample
//
//  Created by Alexandre barbier on 12/11/14.
//  Copyright (c) 2014 Poutsch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VoiceSDK/VoiceSDK.h>
@interface VPCell : UITableViewCell
@property (weak, nonatomic) IBOutlet VPQuestionView *questionView;
@property (strong, nonatomic) NSString *questionId;
@property (assign, nonatomic) BOOL shouldReload;
@end
