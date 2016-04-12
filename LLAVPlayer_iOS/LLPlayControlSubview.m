//
//  LLPlayControlSubview.m
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/11.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import "LLPlayControlSubview.h"

@implementation LLPlayControlSubview

+ (instancetype)viewFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LLPlayControlSubview" owner:nil options:nil] firstObject];
}

- (IBAction)fastbackward:(UIButton *)sender {
    [self.delegate fastbackward];
}

- (IBAction)playback:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
        [self.delegate playVideo];
    } else {
        [sender setTitle:@"Play" forState:UIControlStateNormal];
        [self.delegate pauseVideo];
    }
}

- (IBAction)fastforward:(UIButton *)sender {
    [self.delegate fastforward];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
