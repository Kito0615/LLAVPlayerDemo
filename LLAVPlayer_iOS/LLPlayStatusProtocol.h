//
//  LLPlayStatusProtocol.h
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/11.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LLPlayStatusProtocol <NSObject>

- (void)stopVideo;

- (void)playVideo;

- (void)pauseVideo;

- (void)fastforward;

- (void)fastbackward;

@end
