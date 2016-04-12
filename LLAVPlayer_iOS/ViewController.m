//
//  ViewController.m
//  LLAVPlayer_iOS
//
//  Created by AnarL on 16/4/8.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray * _VideoUrls;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _VideoUrls = [[NSMutableArray alloc] init];
    _source = [LLSource defaultSource];
    self.tableView.rowHeight = 90;
    self.title = @"VideoList";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView:) name:GET_VIDEO_URL_NOTIFICATION object:nil];
    [self.tableView registerNib:[UINib nibWithNibName:@"LLVideoCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTableView:(NSNotification *)notification
{
    NSString * videoString = notification.object;
    [_VideoUrls addObject:videoString];
    
    [self.tableView reloadData];
}

- (NSString *)formatDate:(NSString *)oldDate
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM/dd/yy HH:mm:ss"];
    
    NSDate * oldFormatDate = [df dateFromString:oldDate];
    
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [df stringFromDate:oldFormatDate];
    
    
}

- (NSString *)formatSize:(NSInteger)size
{
    float g = 0, m = 0, k = 0;
    int b = 0;
    if (size >= 1024) {
        b = size % 1024;
        k = size / 1024;
    }
    if (k >= 1024) {
        m = k / 1024;
        k = (int)k % 1024;
    }
    if (m >= 1024) {
        g = m / 1024;
        m = (int)m % 1024;
    }
    
    if (g != 0) {
        return [NSString stringWithFormat:@"%.2fGB", g];
    }
    if (m != 0) {
        return [NSString stringWithFormat:@"%.2fMB", m];
    }
    if (k != 0) {
        return [NSString stringWithFormat:@"%.2fKB", k];
    }
    return [NSString stringWithFormat:@"%dBytes", b];
    
}

- (NSString *)formatDuration:(float)duration
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



#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _VideoUrls.count > 0 ? _VideoUrls.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell"];
    NSDictionary * dict = [[_source fileInfoArray] objectAtIndex:indexPath.row];
    cell.videoName.text = [dict objectForKey:@"fileName"];
    cell.videoSize.text = [self formatSize:[[dict objectForKey:@"fileSize"] integerValue]];
    cell.modifiedDate.text = [self formatDuration:[[dict objectForKey:@"duration"] floatValue]];
    
    [cell setupVideoCell:_VideoUrls[indexPath.row]];
    
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _playerVC = [[LLAVPlayerVC alloc] initWithPlayItemPath:_VideoUrls[indexPath.row]];
    [self.navigationController pushViewController:_playerVC animated:YES];
}
@end
