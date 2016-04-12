//
//  LLPlayStatusSubview.h
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/11.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPlayStatusProtocol.h"

@interface LLPlayStatusSubview : UIView

+ (instancetype)viewFromNib;

- (IBAction)finishPlayback:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationTimeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *playProgress;

@property (nonatomic, weak) id<LLPlayStatusProtocol> delegate;

@end
