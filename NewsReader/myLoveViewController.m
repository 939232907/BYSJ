//
//  myLoveViewController.m
//  zaker
//
//  Created by xuehangzhou on 16/9/23.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import "myLoveViewController.h"
#import "myLoveCell.h"
#import "WebViewController.h"
#import "UIImageView+WebCache.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface myLoveViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * DataSource;
@end

@implementation myLoveViewController

//初始化各種
#pragma mark-Initialize
- (void)setUpUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    UISwipeGestureRecognizer *swipePress = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gesturePressed:)];
    [swipePress setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipePress];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}
//視圖生命週期
#pragma mark-life circle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"我的收藏";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

  
    
    [self setUpUI];
    [self initDataSource];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    [self initDataSource];
    [self.tableView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}
//各種響應事件
#pragma mark-Events
//滑動手勢
- (void)gesturePressed:(UIGestureRecognizer *)gesture
{
    //識別是否為滑動手勢
    if ([gesture isKindOfClass:[UISwipeGestureRecognizer class]])
    {

        UISwipeGestureRecognizer *swipePress = (UISwipeGestureRecognizer *)gesture;
        if (swipePress.state == UIGestureRecognizerStateEnded)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }

    }
}

//其它
#pragma mark-others
- (void)initDataSource
{
    //获取路径
    NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[sandboxpath objectAtIndex:0] stringByAppendingPathComponent:@"mylove.plist"];
    //NSLog(@"%@",NSHomeDirectory());
    //获取数据
    NSArray *arrMain = [NSArray arrayWithContentsOfFile:filePath];
    _DataSource = [NSMutableArray arrayWithArray:arrMain];
    [self.tableView reloadData];
}
//協議
#pragma mark-Protoclo
#pragma mark-UITableViewDataSource ＆＆ UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _DataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myLoveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSLog(@"_DataSource = %@",_DataSource[indexPath.row]);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    [cell.myLoveCellImage sd_setImageWithURL:_DataSource[indexPath.row][@"detailImage"] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.MyloveCellTitleLabel.text = _DataSource[indexPath.row][@"detailTitle"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        WebViewController * webView = [[WebViewController alloc]init];
        webView.detailURL = _DataSource[indexPath.row][@"detailURL"];
        webView.detailTitle = _DataSource[indexPath.row][@"detailTitle"];
        webView.detailImage = _DataSource[indexPath.row][@"detailImage"];
        [self.navigationController pushViewController:webView animated:YES];

}
//懶加載
#pragma mark-getters
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        //_tableView.backgroundColor = [UIColor redColor];
        _tableView.rowHeight = 100.0;
        //注册cell
        [_tableView registerClass:[myLoveCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
@end
