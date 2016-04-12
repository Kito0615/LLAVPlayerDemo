//
//  LLVideoCell.h
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/11.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LLVideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoThumb;
@property (weak, nonatomic) IBOutlet UILabel *videoName;
@property (weak, nonatomic) IBOutlet UILabel *videoSize;
@property (weak, nonatomic) IBOutlet UILabel *modifiedDate;

- (void)setupVideoCell:(NSString *)videoUrlString;
@end
