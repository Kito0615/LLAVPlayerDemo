//
//  LLPlayControlView.m
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/11.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import "LLPlayControlView.h"
#import "LLPlayControlSubview.h"
#import "LLPlayStatusSubview.h"

@interface LLPlayControlView()
{
    LLPlayStatusSubview * topStatusView;
    LLPlayControlSubview * bottomControlView;
}
@end
@implementation LLPlayControlView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubViews];
        [self setupGestures];
    }
    return self;
}
- (void)setupSubViews
{
    //监听手机方向改变事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    topStatusView = [LLPlayStatusSubview viewFromNib];
    topStatusView.delegate = self;
    topStatusView.frame = CGRectMake(0, 0, self.bounds.size.width, 60);
    topStatusView.backgroundColor = [UIColor lightGrayColor];
    topStatusView.alpha = 0.85;
    
    bottomControlView = [LLPlayControlSubview viewFromNib];
    bottomControlView.delegate = self;
    bottomControlView.frame = CGRectMake(0, self.bounds.size.height - 60, self.bounds.size.width, 60);
    bottomControlView.backgroundColor = [UIColor lightGrayColor];
    bottomControlView.alpha = 0.85;
    
    [self addSubview:topStatusView];
    [self addSubview:bottomControlView];
    topStatusView.hidden = YES;
    bottomControlView.hidden = YES;
}

- (void)setupGestures
{
    UISwipeGestureRecognizer * leftSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureToggled:)];
    leftSwipeGR.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:leftSwipeGR];
    
    UISwipeGestureRecognizer * rightSwipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureToggled:)];
    rightSwipeGR.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipeGR];
    
    UITapGestureRecognizer * doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestureToggled:)];
    doubleTapGR.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTapGR];
    UITapGestureRecognizer * singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureToggled:)];
    [singleTapGR requireGestureRecognizerToFail:doubleTapGR];
    [self addGestureRecognizer:singleTapGR];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark -UIGestureRecognizerAction
- (void)swipeGestureToggled:(UISwipeGestureRecognizer *)swipe
{
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"right");
            [self.delegate fastforward];
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"left");
            [self.delegate fastbackward];
            break;
            
        default:
            break;
    }
}

- (void)tapGestureToggled:(UITapGestureRecognizer *)tap
{
    NSLog(@"single tap");
    
    if (topStatusView.hidden) {
        topStatusView.hidden = NO;
        topStatusView.alpha = 0.0;
        bottomControlView.hidden = NO;
        bottomControlView.alpha = 0.0;
        [UIView animateWithDuration:0.5 animations:^{
            topStatusView.alpha = 0.85;
            bottomControlView.alpha = 0.85;
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            bottomControlView.alpha = 0.0;
            topStatusView.alpha = 0.0;
        } completion:^(BOOL finished) {
            bottomControlView.hidden = YES;
            topStatusView.hidden = YES;
        }];
        
    }
    
}

- (void)doubleTapGestureToggled:(UITapGestureRecognizer *)tap
{
    NSLog(@"double tap");
    
    if (!self.isPlaying) {
        [self.delegate playVideo];
    } else {
        [self.delegate pauseVideo];
    }
}


#pragma mark -UIDeveiceOrientation

-(void) orientationChanged

{
    self.frame = [UIScreen mainScreen].bounds;
    [self layoutSubviews];    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    topStatusView.frame = CGRectMake(0, 0, self.bounds.size.width, 60);
    bottomControlView.frame = CGRectMake(0, self.bounds.size.height - 60, self.bounds.size.width, 60);
}
#pragma mark -Setters
- (void)setPlayingProgress:(float)playingProgress
{
    _playingProgress = playingProgress;
    topStatusView.playProgress.progress = _playingProgress;
}

- (void)setCurrentTimeString:(NSString *)currentTimeString
{
    _currentTimeString = currentTimeString;
    topStatusView.currentTimeLabel.text = _currentTimeString;
}

- (void)setDurationTimeString:(NSString *)durationTimeString
{
    _durationTimeString = durationTimeString;
    topStatusView.durationTimeLabel.text = _durationTimeString;
}

#pragma mark -LLPlayStatusProtocol
- (void)stopVideo
{
    [self.delegate stopVideo];
}

- (void)playVideo
{
    [self.delegate playVideo];
    self.isPlaying = YES;
}

- (void)pauseVideo
{
    [self.delegate pauseVideo];
    self.isPlaying = NO;
}

- (void)fastbackward
{
    [self.delegate fastbackward];
}


- (void)fastforward
{
    [self.delegate fastforward];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    NSLog(@"%s", __func__);
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __func__);
}

@end
