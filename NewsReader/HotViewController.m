//
//  ViewController.m
//  NewsReader
//
//  Created by xue on 2017/4/21.
//  Copyright © 2017年 薛航舟. All rights reserved.
//

#import "HotViewController.h"
#import "HotCell.h"
#import "InfoModel.h"
#import "NetRequst.h"
#import "APIConfig.h"
//引入SDWebImage
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
@interface HotViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSArray<InfoModel *> * DataSource;
@end

@implementation HotViewController

#pragma mark-初始化
//設定用戶界面
- (void)setUpUI
{
    self.view.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[HotCell class] forCellReuseIdentifier:@"cell"];
    _tableView.rowHeight = 240.0;
    [self.view addSubview:self.tableView];
}
#pragma mark-視圖生命週期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self initDataSource];
}
#pragma mark-響應事件

#pragma mark-其它
- (void)initDataSource
{
    NSDictionary * newsDIC = @{@"type":TOP,@"key":KEY};
    [NetRequst GET:BASEURL parameters:newsDIC success:^(id responseObject) {
        _DataSource = [InfoModel InfoModelArrayFromJSONArray:responseObject[@"result"][@"data"]];
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"error=%@",error);
    }];
    
}
#pragma mark-協議
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _DataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
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
