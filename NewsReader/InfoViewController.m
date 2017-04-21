//
//  InfoViewController.m
//  NewsReader
//
//  Created by xue on 2017/4/21.
//  Copyright © 2017年 薛航舟. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoCell.h"
#import "NetRequst.h"
#import "APIConfig.h"
#import "InfoModel.h"
#import "WebViewController.h"
//引入SDWebImage
#import "UIImageView+WebCache.h"
@interface InfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSArray * kindArray;
@property (nonatomic,strong)NSArray<InfoModel *> * DataSource;
@end

@implementation InfoViewController

#pragma mark-初始化
//設定用戶界面
- (void)setUpUI
{
    self.title = _InfoTitle;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[InfoCell class] forCellReuseIdentifier:@"cell"];
    _tableView.rowHeight = 240.0;
    [self.view addSubview:self.tableView];
}
#pragma mark-視圖生命週期
- (instancetype)init
{
    self = [super init];
    if (self) {
        _kindArray = @[@"TOP",@"SHEHUI",@"GUONEI",@"GUOJI",@"YULE",@"TIYU",@"JUNSHI",@"KEJI",@"CAIJING",@"SHICHANG"];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self initDataSource];
    
}
#pragma mark-響應事件

#pragma mark-其它
- (void)initDataSource
{
    NSDictionary * newsDIC = @{@"type":_kindArray[_index],@"key":KEY};
    [NetRequst GET:BASEURL parameters:newsDIC success:^(id responseObject) {
        _DataSource = [InfoModel InfoModelArrayFromJSONArray:responseObject[@"result"][@"data"]];
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"error=%@",error);
    }];

}
#pragma mark-協議
#pragma mark-UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _DataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = _DataSource[indexPath.row].title;
    cell.authorLabel.text = _DataSource[indexPath.row].author_name;
    cell.dateTime.text = _DataSource[indexPath.row].date;
    NSURL * imageURL = [NSURL URLWithString:_DataSource[indexPath.row].thumbnail_pic_s];
    [cell.infoImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController * webView = [[WebViewController alloc]init];
    webView.detailURL = _DataSource[indexPath.row].url;
    webView.detailTitle = _DataSource[indexPath.row].title;
    webView.detailImage = _DataSource[indexPath.row].thumbnail_pic_s;
    webView.author_name = _DataSource[indexPath.row].author_name;
    webView.date = _DataSource[indexPath.row].date;
    [self.navigationController pushViewController:webView animated:YES];
}
#pragma mark-懶加載

@end
