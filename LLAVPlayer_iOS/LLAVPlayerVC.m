//
//  LLAVPlayerVC.m
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/11.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import "LLAVPlayerVC.h"
#import "LLPlayControlView.h"

@interface LLAVPlayerVC ()<LLPlayStatusProtocol>
{
    AVAsset * _asset;
    AVPlayer * _player;
    AVPlayerItem * _item;
    LLPlayControlView * _playControlView;
    NSTimer * _timer;
}
@end

@implementation LLAVPlayerVC
- (instancetype)initWithPlayItemPath:(NSString *)itemPath
{
    if (self = [super init]) {
        [self setupPlayerWithPath:itemPath];
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_player) {
        [self stopVideo];
    }
}

- (void)setupPlayerWithPath:(NSString *)path
{
    _asset = [AVAsset assetWithURL:[[NSURL alloc] initFileURLWithPath:path]];
    _item = [AVPlayerItem playerItemWithAsset:_asset];
    _player = [AVPlayer playerWithPlayerItem:_item];
    self.showsPlaybackControls = NO;
    
    self.player = _player;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    _playControlView = [[LLPlayControlView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _playControlView.delegate = self;
    [self.view addSubview:_playControlView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishedPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

#pragma mark -PlayItemStatusNotification
- (void)didFinishedPlay:(NSNotification *)notice
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -LLPlayControlDelegate
- (void)playVideo
{
    [self.player play];
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    } else {
        [_timer setFireDate:[NSDate distantPast]];
    }
}

- (void)pauseVideo
{
    [self.player pause];
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)stopVideo
{
    [self.player pause];
    [self.navigationController popViewControllerAnimated:YES];
    [_timer invalidate];
}

- (void)fastforward
{
    CMTime currentTime = _item.currentTime;
    CMTime forwardTime = CMTimeMake(currentTime.value + 5, currentTime.timescale);
    [_player seekToTime:forwardTime];
}

- (void)fastbackward
{
    CMTime currentTime = _item.currentTime;
    CMTime backwardTime = CMTimeMake(currentTime.value - 5, currentTime.timescale);
    [_player seekToTime:backwardTime];
}
#pragma mark -TimerFunction
- (void)updateProgress
{
    NSInteger duration = (NSInteger)(_item.duration.value / _item.duration.timescale);
    NSInteger current = (NSInteger)(_item.currentTime.value / _item.currentTime.timescale);
    
    _playControlView.playingProgress = current * 1.0 / duration;
    _playControlView.currentTimeString = [self formatDuration:current];
    _playControlView.durationTimeString = [self formatDuration:duration];
}

- (NSString *)formatDuration:(NSInteger)duration
{
    NSInteger h = 0, m = 0, s = 0;
    
    s = (int)duration;
    
    if (duration >= 60) {
        s = (int)duration % 60;
        m = duration / 60;
    }
    if (m >= 60) {
        h = m / 60;
        m = m % 60;
    }
    
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", h, m, s];
}

@end
