//
//  LLVideoCell.m
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/11.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import "LLVideoCell.h"

@implementation LLVideoCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setupVideoCell:(NSString *)videoUrlString
{
    AVURLAsset * asset = [AVURLAsset assetWithURL:[[NSURL alloc] initFileURLWithPath:videoUrlString]];
    
    self.videoThumb.image = [self getVideoThumbWithAsset:asset];
}

- (UIImage *)getVideoThumbWithAsset:(AVURLAsset *)asset
{
    AVAssetImageGenerator * generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    CMTime actualTime;
    NSError * error = nil;
    CGImageRef imageRef = [generator copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage * thumb = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return thumb;
}
@end
