//
//  LLPlayControlSubview.h
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/11.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPlayStatusProtocol.h"

@interface LLPlayControlSubview : UIView

@property (nonatomic, weak) id <LLPlayStatusProtocol> delegate;

+ (instancetype)viewFromNib;

- (IBAction)fastbackward:(UIButton *)sender;
- (IBAction)playback:(UIButton *)sender;
- (IBAction)fastforward:(UIButton *)sender;

@end
