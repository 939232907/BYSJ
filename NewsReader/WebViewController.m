//
//  WebViewController.m
//  zaker
//
//  Created by xuehangzhou on 16/9/23.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import "WebViewController.h"
@interface WebViewController ()
@property (nonatomic,strong)UIView *webTool;
@property (nonatomic,strong)UIButton * loveButton;
@property (nonatomic,strong)UIWebView *webview;
@end

@implementation WebViewController
//初始化各種
#pragma mark-Initialize
- (void)setUpUI
{

    self.view.backgroundColor = [UIColor whiteColor];
    //NSLog(@"%@",_detailURL);
    _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _webview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webview];
    //加載網址
    NSURL *url = [NSURL URLWithString:_detailURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
    
    [self.view addSubview:self.webTool];
    UISwipeGestureRecognizer *swipePress = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gesturePressed:)];
    [swipePress setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipePress];

}
//視圖生命週期
#pragma mark-life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];


}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;


    //获取路径
    NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[sandboxpath objectAtIndex:0] stringByAppendingPathComponent:@"mylove.plist"];
    //NSLog(@"%@",NSHomeDirectory());
    //获取数据
    NSArray *arrMain = [NSArray arrayWithContentsOfFile:filePath];

    for (NSDictionary * localInfo in arrMain)
    {
        if ([localInfo[@"detailURL"] isEqualToString:_detailURL])
        {
            _loveButton.selected = YES;
        }
        else
        {

        }
    }





}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
}
//各種響應事件
#pragma mark-Events
- (void)upView
{
    [self.navigationController popViewControllerAnimated:YES];
}
//滑動手勢
- (void)gesturePressed:(UIGestureRecognizer *)gesture
{
        //識別是否為滑動手勢
        if ([gesture isKindOfClass:[UISwipeGestureRecognizer class]])
        {

        UISwipeGestureRecognizer *swipePress = (UISwipeGestureRecognizer *)gesture;
        if (swipePress.state == UIGestureRecognizerStateEnded)
        {
            [self upView];
        }

        }
}
- (void)loveButtonClick:(UIButton *)sender
{
    if (sender.selected == NO)
    {
        sender.selected = YES;
        //UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"溫馨提示" message:@"收藏成功了" preferredStyle:UIAlertControllerStyleAlert];
        //UIAlertAction * sure = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:nil];
        //[alert addAction:sure];
       // [self presentViewController:alert animated:YES completion:nil];

        [self writeFileToplist];
    }
    else
    {
        sender.selected = NO;
        //UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"溫馨提示" message:@"取消收藏了" preferredStyle:UIAlertControllerStyleAlert];
        //UIAlertAction * sure = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:nil];
        //[alert addAction:sure];
        ///[self presentViewController:alert animated:YES completion:nil];

        [self removeFileToplist];

    }

}
//其它
#pragma mark-others
-(void)writeFileToplist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);



    //获取完整路径

    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"mylove.plist"];//这里就是你将要存储的沙盒路径（.plist文件，名字自定义）


    if(![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {//plistPath这个文件\文件夹是否存在
        // - 什么是NSFileManager

        //  顾名思义, NSFileManager是用来管理文件系统的
        //它可以用来进行常见的文件\文件夹操作
        //NSFileManager使用了单例模式

        //使用defaultManager方法可以获得那个单例对象
        //[NSFileManager defaultManager]

        NSMutableArray *dictplist = [[NSMutableArray alloc] init];

        NSDictionary * localInfo = [NSDictionary dictionaryWithObjectsAndKeys:_detailTitle,@"detailTitle",_detailImage,@"detailImage",_detailURL,@"detailURL" ,_author_name,@"author_name",_date,@"date",nil];
        [dictplist insertObject:localInfo atIndex:0];

        [dictplist writeToFile:plistPath atomically:YES];
        NSLog(@"------1----- %@写入是否成功%d",dictplist,[dictplist writeToFile:plistPath atomically:YES]);
    }
    else
    {
        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];


        NSDictionary * localInfo = [NSDictionary dictionaryWithObjectsAndKeys:_detailTitle,@"detailTitle",_detailImage,@"detailImage",_detailURL,@"detailURL" ,_author_name,@"author_name",_date,@"date",nil];

        [array insertObject:localInfo atIndex:0];

        [array writeToFile:plistPath atomically:YES];
        //NSLog(@"-------2----%@写入成功",array);

        //NSLog(@"%@",plistPath);
    }
}
-(void)removeFileToplist
{
    //获取路径
    NSArray *sandboxpath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[sandboxpath objectAtIndex:0] stringByAppendingPathComponent:@"mylove.plist"];
    //获取数据
    NSMutableArray *arrMain = [NSMutableArray arrayWithContentsOfFile:filePath];

    for (NSDictionary * localInfo in arrMain)
    {
        if ([localInfo[@"detailURL"] isEqualToString:_detailURL])
        {
            NSMutableArray * arr = [NSMutableArray arrayWithArray:arrMain];
            [arr removeObject:localInfo];
            arrMain = arr;
        }
    }



    [arrMain removeObject:_detailURL];

    
//    [arrMain enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
//
//        if ([obj[@"detailURL"] isEqualToString:_detailURL]) {
//
//            *stop = YES;
//
//            if (*stop == YES) {
//
//                [arrMain replaceObjectAtIndex:idx withObject:@""];
//                
//            }
//            
//        }
//        
//        if (*stop) {
//            
//            NSLog(@"array is %@",arrMain);
//            
//        }
//        
//    }];
//
    [arrMain writeToFile:filePath atomically:YES];




}
- (void)creatAlert:(NSTimer *)timer{
    UIAlertController *alert = [timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    alert = nil;
}
//協議
#pragma mark-Protoclo
//懶加載
#pragma mark-getters
- (UIView *)webTool
{
    if (!_webTool)
    {
        _webTool = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 34, self.view.bounds.size.width, 34)];
        //_webTool.backgroundColor = [UIColor blueColor];
        _webTool.backgroundColor = [UIColor whiteColor];
        UIButton * upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [upButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        upButton.titleLabel.font = [UIFont systemFontOfSize:15];
        upButton.frame = CGRectMake((self.view.frame.size.width) / 8, 8, 16, 16);
        [upButton setBackgroundImage:[UIImage imageNamed:@"上一页.png"] forState:UIControlStateNormal];
        [upButton addTarget:self action:@selector(upView) forControlEvents:UIControlEventTouchUpInside];
        [_webTool addSubview:upButton];

        _loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loveButton.selected = NO;
        [_loveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loveButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _loveButton.frame = CGRectMake((self.view.frame.size.width) / 2, 8, 32, 16);
        [_loveButton setBackgroundImage:[UIImage imageNamed:@"nolove.png"] forState:UIControlStateNormal];
        [_loveButton setBackgroundImage:[UIImage imageNamed:@"love.png"] forState:UIControlStateSelected];
        [_loveButton addTarget:self action:@selector(loveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_webTool addSubview:_loveButton];














        
    }
    return _webTool;
}


@end
