//
//  LLAVPlayerVC.h
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/11.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LLAVPlayerVC : AVPlayerViewController
- (instancetype)initWithPlayItemPath:(NSString *)itemPath;
@end
