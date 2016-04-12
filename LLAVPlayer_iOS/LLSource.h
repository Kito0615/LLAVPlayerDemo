//
//  LLSource.h
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/8.
//  Copyright © 2016年 AnarL. All rights reserved.
//
#define GET_VIDEO_URL_NOTIFICATION @"getVideoUrl"

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface LLSource : NSObject
{
    ALAssetsLibrary * _library;
}

@property (nonatomic, strong) NSMutableArray * fileInfoArray;

+ (instancetype)defaultSource;

@end
