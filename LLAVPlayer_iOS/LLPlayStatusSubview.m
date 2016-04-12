//
//  LLPlayStatusSubview.m
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/11.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import "LLPlayStatusSubview.h"

@implementation LLPlayStatusSubview

+ (instancetype)viewFromNib
{
    NSArray * nibView = [[NSBundle mainBundle] loadNibNamed:@"LLPlayStatusSubview" owner:nil options:nil];
    return  [nibView firstObject];
}

- (IBAction)finishPlayback:(UIButton *)sender {
    [self.delegate stopVideo];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
