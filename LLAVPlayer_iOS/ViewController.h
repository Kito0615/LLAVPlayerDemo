//
//  ViewController.h
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/8.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLSource.h"
#import "LLVideoCell.h"
#import "LLAVPlayerVC.h"

@interface ViewController : UITableViewController
{
    LLSource * _source;
    LLAVPlayerVC * _playerVC;
}

@end

