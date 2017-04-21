//
//  MineViewController.m
//  NewsReader
//
//  Created by xue on 2017/4/21.
//  Copyright © 2017年 薛航舟. All rights reserved.
//

#import "MineViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "myLoveViewController.h"
#import "ProgressHUD.h"
#import "SDImageCache.h"
#import "MineCell.h"
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSArray * DataSource;
@end

@implementation MineViewController

#pragma mark-初始化
//設定用戶界面
- (void)setUpUI
{
    self.view.backgroundColor = [UIColor redColor];
    _DataSource = @[@"我的收藏",@"缓存清除",@"推送设置",@"关于毕业设计"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[MineCell class] forCellReuseIdentifier:@"cell"];
    _tableView.rowHeight = 60;
    _tableView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    [self.view addSubview:self.tableView];
}
#pragma mark-視圖生命週期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}
#pragma mark-響應事件

#pragma mark-其它

#pragma mark-協議
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _DataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = _DataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.iconImageView.image = [UIImage imageNamed:_DataSource[indexPath.row]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        //        myLoveViewController * myLoveView = [[myLoveViewController alloc]init];
        //        UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        //        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        //        self.navigationItem.backBarButtonItem=back;
        //        [self.navigationController pushViewController:myLoveView animated:YES];
        
        //初始化上下文对象
        LAContext* context = [[LAContext alloc] init];
        //错误对象
        NSError* error = nil;
        NSString* result = @"請輸入您的指紋！";
        
        //首先使用canEvaluatePolicy 判断设备支持状态
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            //支持指纹验证
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
                if (success) {
                    //验证成功，主线程处理UI
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        myLoveViewController * myLoveView = [[myLoveViewController alloc]init];
                        UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
                        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
                        self.navigationItem.backBarButtonItem=back;
                        [self.navigationController pushViewController:myLoveView animated:YES];
                    }];
                    NSLog(@"OK!");
                    //                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"溫馨提示" message:@"驗證成功" preferredStyle:UIAlertControllerStyleAlert];
                    //                    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //                        myLoveViewController * myLoveView = [[myLoveViewController alloc]init];
                    //                        UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
                    //                        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
                    //                        self.navigationItem.backBarButtonItem=back;
                    //                        [self.navigationController pushViewController:myLoveView animated:YES];
                    //                    }];
                    //                    [alert addAction:sure];
                    //                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
                else
                {
                    NSLog(@"%@",error.localizedDescription);
                    switch (error.code) {
                        case LAErrorSystemCancel:
                        {
                            NSLog(@"Authentication was cancelled by the system");
                            //切换到其他APP，系统取消验证Touch ID
                            break;
                        }
                        case LAErrorUserCancel:
                        {
                            NSLog(@"Authentication was cancelled by the user");
                            //用户取消验证Touch ID
                            break;
                        }
                        case LAErrorUserFallback:
                        {
                            NSLog(@"User selected to enter custom password");
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                //用户选择输入密码，切换主线程处理
                                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"溫馨提示" message:@"為了安全zaker只能使用TouchID" preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction * sure = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                                    
                                }];
                                [alert addAction:sure];
                                [self presentViewController:alert animated:YES completion:nil];
                            }];
                            break;
                        }
                        default:
                        {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                //其他情况，切换主线程处理
                                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"溫馨提示" message:@"驗證失敗" preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction * sure = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                                    
                                }];
                                [alert addAction:sure];
                                [self presentViewController:alert animated:YES completion:nil];
                            }];
                            break;
                        }
                    }
                }
            }];
        }
        else
        {
            //不支持指纹识别，LOG出错误详情
            
            switch (error.code) {
                case LAErrorTouchIDNotEnrolled:
                {
                    NSLog(@"TouchID is not enrolled");
                    break;
                }
                case LAErrorPasscodeNotSet:
                {
                    NSLog(@"A passcode has not been set");
                    break;
                }
                default:
                {
                    NSLog(@"TouchID not available");
                    break;
                }
            }
            
            NSLog(@"%@",error.localizedDescription);
        }
        
        
        
    }
    else if (indexPath.row == 1)
    {
        float ImageCache = [[SDImageCache sharedImageCache]getSize]/1000/1000;
        NSString * CacheString = [NSString stringWithFormat:@"缓存大小为%.2fM.确定要清理缓存么?",ImageCache];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:CacheString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[SDImageCache sharedImageCache]clearDisk];
        }];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:sure];
        [alert addAction:cancle];
        [self presentViewController:alert animated:YES completion:nil];

    }
    else if (indexPath.row == 2)
    {
        [ProgressHUD showError:@"没有开发者账号，该功能暂未实现"];
    }
    else if (indexPath.row == 3)
    {
        [ProgressHUD showSuccess:@"web2班薛航舟制作、项目号：J1701085" Interaction:NO];
    }
    
}
#pragma mark-懶加載

@end
