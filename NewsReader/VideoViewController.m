//
//  VideoViewController.m
//  NewsReader
//
//  Created by xue on 2017/4/21.
//  Copyright © 2017年 薛航舟. All rights reserved.
//

#import "VideoViewController.h"
#import "QSRefreshTableViewWithMAMAAnimation.h"
#import "Adaption.h"
#import "NetRequestManager.h"
#import "UIImageView+WebCache.h"
#import "ProgressHUD.h"
#import "QSKeyWords.h"
#import "QSVideoModel.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "QSVideoCell.h"
#import "QSVideoPlayButton.h"
#import "WebViewController.h"
#define KWIDTH ([[UIScreen mainScreen] bounds].size.width)
#define IMG_HEIGHT (KWIDTH * (9.0 / 16.0))
@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate,QSVideoCellDelegate>
@property (nonatomic,strong)QSRefreshTableViewWithMAMAAnimation * tableView;
@property (nonatomic,strong)NSMutableArray * dataSource;
@property (nonatomic,assign)NSInteger  pageNumber;
@property (nonatomic,strong)NSMutableArray<QSVideoModel *> * modelDataSource;
@property (nonatomic,strong)QSVideoPlayButton * playerView;
//当前是那个cell index 的视频在播放
@property (nonatomic,strong) NSIndexPath * playIndexPath;

//是否有视频播放
@property (nonatomic,assign) BOOL isPlay;
@end

@implementation VideoViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataSource = [NSMutableArray array];
        _pageNumber = 0;
        _modelDataSource = [NSMutableArray array];
    }
    return self;
}
#pragma mark-初始化
//設定用戶界面
- (void)setUpUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[QSRefreshTableViewWithMAMAAnimation alloc]initWithFrame:CGRectMake(0, 0, QSKWidth, QSKHeight) style:UITableViewStylePlain withTag:210 withDelegate:self withCellName:@"QSVideoCell" withRowHeight:350 withReuseIdentifier:@"cell" withRefreshBlock:^(UITableView *sender) {
        [self initData];
    } withLoadMoreBlock:^(UITableView *sender) {
        [self initData];
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
#pragma mark-視圖生命週期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isPlay = false;
    [self setUpUI];
    [self initData];
}
#pragma mark-響應事件

#pragma mark-其它
- (void)initData
{
    _pageNumber ++;
    NSString * pageStr = [NSString stringWithFormat:@"%ld",_pageNumber];
    [NetRequestManager postCateG:@"" method:@"article" action:@"getArticleList" paramters:@{@"sPage":pageStr,@"sPagesize":@20,@"sIsVideo":@"1"} success:^(id response) {
        NSArray * testArr = response[@"info"][@"data"];
        if (testArr.count == 0)
        {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [ProgressHUD showError:@"暫無更多推薦內容，請重新刷新！"];
            _pageNumber = 0;
        }
        else
        {
            _modelDataSource = [[QSVideoModel QSVideoModelFromJSONArray:response[@"info"][@"data"]] mutableCopy];
            _dataSource = response[@"info"][@"data"];
            [_tableView reloadData];
            //[ProgressHUD showSuccess:@"刷新成功"];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
        
        
        
    } failure:^(NSError *error) {
        [ProgressHUD showError:@"刷新失敗，網絡超時！"];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (NSString *)stringFromDate:(NSDate *)date dateFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];//  设置显示风格
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//  设置时区
    [formatter setTimeZone:timeZone];
    return [formatter stringFromDate:date];
}
- (NSString *)stringFromTimeInterval:(NSString *)TimeIntervalString dateFormatter:(NSString *)format{
    return [self stringFromDate:[NSDate dateWithTimeIntervalSince1970:[TimeIntervalString integerValue]] dateFormatter:format];
}
#pragma mark-協議
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QSVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.dataSource = _dataSource;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataDict = _dataSource[indexPath.row];
    cell.indexPath = indexPath;
    [cell.videoImageView sd_setImageWithURL:_dataSource[indexPath.row][@"sThumb"] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.lastVC = self;
    
    //NSLog(@"%@",_dataSource);
    NSString * talkKindsStr = [NSString stringWithFormat:@"#%@", _dataSource[indexPath.row][@"sCatename"]];
    //  NSLog(@"talkKindsStr = %@",talkKindsStr);
    [cell.kindButton setTitle:talkKindsStr forState:UIControlStateNormal];
    
    cell.tableViewIndex = indexPath.row;
    //cell.titleLabel.text = _dataSource[indexPath.row][@"sTitle"];
    cell.titleLabel.text = _modelDataSource[indexPath.row].sTitle;
    cell.infoLabel.text = _dataSource[indexPath.row][@"sIntro"];
    cell.delegate = self;
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController * webVC = [[WebViewController alloc]init];
    webVC.detailURL = _dataSource[indexPath.row][@"sShareurl"];
    webVC.detailTitle = _dataSource[indexPath.row][@"sTitle"];
    webVC.detailImage = _dataSource[indexPath.row][@"sAvatar"];
    webVC.author_name = _dataSource[indexPath.row][@"sUsername"];
    NSString * lo = [self stringFromTimeInterval:_dataSource[indexPath.row][@"sAddtime"] dateFormatter:@"2016-12-12"];
    webVC.date = lo;
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //在cell didEndDisplayingCell 消失的代理事件中处理小窗口播放视频
    if (indexPath.row == self.playIndexPath.row && self.playIndexPath != nil) {
        
        //cell contentView 上移除视频播放的窗口视图
        [self.playerView removeFromSuperview];
        //改变frame 在小窗口视图上播放
        self.playerView.frame = CGRectMake(self.view.frame.size.width-180, self.view.frame.size.height-213+64, 180, 100);
        //加载到self.view 上面
        [self.view addSubview:self.playerView];
        //显示 关闭播放的按钮
        [self.playerView.closeButton setHidden:false];
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //如果播放的indexPath 不为空，且等于当前出现的 indexPath ,那么小窗口播放界面移除，改变playerView 的frame，加载到cell 的 contentView 上面。
    if ((self.playIndexPath.row == indexPath.row) && self.playIndexPath != nil) {
        //小的视频播放窗口移除
        [self.playerView removeFromSuperview];
        //改变尺寸，
        self.playerView.frame = CGRectMake(0, 0, self.view.frame.size.width, IMG_HEIGHT);
        //加载到当前cell contentView 上面
        [cell.contentView addSubview:self.playerView];
        //隐藏 关闭播放的按钮
        [self.playerView.closeButton setHidden:true];
    }
}

- (void)QSVideoCellPlayDelegateClick:(NSDictionary *)dataDict Cell:(QSVideoCell *)cell
{
    if (self.playIndexPath.row == cell.indexPath.row && self.playIndexPath != nil) {
        //播放按钮代理事件处理，如果有视频在播放，判断 index 如果和 当前播放的 playIndexPath 一样，就改变isPlay 为NO
        
        if (self.isPlay) {
            self.isPlay = NO;
        }
        else {
            self.isPlay = YES;
        }
    }else {
        // index 不一样
        [self.playerView removeFromSuperview];
        
        //playerView 重新设置
        self.playerView.frame = CGRectMake(0, 0, self.view.frame.size.width, IMG_HEIGHT);
        self.playerView.backgroundColor = [UIColor blackColor];
        self.playIndexPath = cell.indexPath;
        self.isPlay = true;
        [self.playerView playURL:[NSURL URLWithString:[dataDict objectForKey:@"sVideoUrl"]]];
        [self.playerView.closeButton setHidden:true];
        
        //playerView 加载到被点击的cell 上面
        [cell.contentView addSubview:self.playerView];
    }
    
}


#pragma mark-懶加載
-(QSVideoPlayButton *)playerView{
    if (!_playerView) {
        _playerView = [[QSVideoPlayButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, IMG_HEIGHT)];
        [_playerView.closeButton addTarget:self action:@selector(stopPlayer) forControlEvents:UIControlEventTouchUpInside];
        [_playerView.closeButton setHidden:true];
    }
    return _playerView;
}
#pragma mark -- 停止播放按钮点击事件
- (void)stopPlayer {
    [self.playerView.playerController.player pause];
    self.isPlay = false;
    [self.playerView removeFromSuperview];
    self.playIndexPath = nil;
}
@end
