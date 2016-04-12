//
//  LLSource.m
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/8.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#define MOV_PATH [NSTemporaryDirectory() stringByAppendingPathComponent:@"file%ld.mov"]

#import "LLSource.h"
@interface LLSource()
{
    NSMutableArray * _assetsArray;
}
@end

@implementation LLSource

+ (instancetype)defaultSource
{
    static LLSource * source = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        source = [[LLSource alloc] init];
    });
    
    return source;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupDataSource];
        
        _fileInfoArray = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)setupDataSource
{
    _library = [[ALAssetsLibrary alloc] init];
    _assetsArray = [NSMutableArray array];
    [_library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            NSString *  assetType = [result valueForProperty:ALAssetPropertyType];
            
            static NSInteger videoIndex = 0;
            
            if ([assetType isEqualToString:ALAssetTypeVideo]) {
                NSLog(@"Video ====");
                NSNumber * assetDuration = [result valueForProperty:ALAssetPropertyDuration];
                NSNumber * assetOrientation = [result valueForProperty:ALAssetPropertyOrientation];
                NSDate * assetDate = [result valueForProperty:ALAssetPropertyDate];
                NSArray * assetRepresentations = [result valueForProperty:ALAssetPropertyRepresentations];
                ALAssetRepresentation * defaultRepresentation = [result defaultRepresentation];
                NSDictionary * assetUrls = [result valueForProperty:ALAssetPropertyURLs];
                NSURL * assetUrl = [result valueForProperty:ALAssetPropertyAssetURL];
                
                NSLog(@"duration = %@", assetDuration);
                NSLog(@"orientation= %@", assetOrientation);
                NSLog(@"date = %@", assetDate);
                NSLog(@"representation = %@", assetRepresentations);
                NSLog(@"urls = %@", assetUrls);
                NSLog(@"url = %@", assetUrl);
                
                NSLog(@"size = %llu", (unsigned long long)[defaultRepresentation size]);                NSLog(@"name = %@", [defaultRepresentation filename]);
                NSLog(@"dimensions = %@", [NSString stringWithFormat:@"%dpx x %dpx", (int)[defaultRepresentation dimensions].width, (int)[defaultRepresentation dimensions].height]);
                NSLog(@"Url = %@", [defaultRepresentation url]);
                NSLog(@"UTI = %@", [defaultRepresentation UTI]);
                
                NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:assetDuration, @"duration", @([defaultRepresentation size]), @"fileSize", [defaultRepresentation filename], @"fileName", nil];
                
                [_fileInfoArray addObject:dict];
                
                NSString * filePath = [NSString stringWithFormat:MOV_PATH, videoIndex ++];
                
                Byte * buffer = (Byte *)malloc(defaultRepresentation.size);
                
                NSUInteger buffered = [defaultRepresentation getBytes:buffer fromOffset:0.0 length:defaultRepresentation.size error:nil];
                
                NSData * data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
                
                [data writeToFile:filePath atomically:YES];
                
                NSLog(@"%@", filePath);
                
                [[NSNotificationCenter defaultCenter] postNotificationName:GET_VIDEO_URL_NOTIFICATION object:filePath];
            }
            
        } ];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Error ----------%@", [error localizedDescription]);
    }];
}

@end
