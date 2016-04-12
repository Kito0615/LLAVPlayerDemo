//
//  LLPlayControlView.h
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/11.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPlayStatusProtocol.h"

@interface LLPlayControlView : UIView <LLPlayStatusProtocol>

@property (nonatomic, copy) NSString * currentTimeString;
@property (nonatomic, copy) NSString * durationTimeString;
@property (nonatomic, assign) float playingProgress;
@property (nonatomic, assign) float controlRate;

@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, weak) id<LLPlayStatusProtocol> delegate;

@end
