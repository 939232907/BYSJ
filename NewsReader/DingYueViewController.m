//
//  DingYueViewController.m
//  NewsReader
//
//  Created by xue on 2017/4/21.
//  Copyright © 2017年 薛航舟. All rights reserved.
//

#import "DingYueViewController.h"
//引入轮播图三方库
#import "SDCycleScrollView.h"
//引入自定义的网络支持文件
#import "NetRequst.h"
//引入接口配置文件
#import "APIConfig.h"
//引入自定义瀑布流cell
#import "MyCollectionViewCell.h"
//引入自定义WebViewController
#import "WebViewController.h"
//引入类别详情页
#import "InfoViewController.h"
@interface DingYueViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
//轮播图
@property (nonatomic,strong)SDCycleScrollView * SDCarouselImageScrollView;
//轮播图数组
@property (nonatomic,strong)NSMutableArray * SDArray;
//轮播图图片URL数组
@property (nonatomic,strong)NSMutableArray * imageURLArr;
//轮播图文字URL数组
@property (nonatomic,strong)NSMutableArray * titleLabelArr;
//瀑布流数据源
@property (nonatomic,strong)NSArray * CollectionDataSource;
@property (nonatomic,strong)UICollectionView *mainCollectionView;
@end

@implementation DingYueViewController
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _SDArray = [NSMutableArray array];
        _imageURLArr = [NSMutableArray array];
        _titleLabelArr = [NSMutableArray array];
        _CollectionDataSource = [@[@"头条",@"社会",@"国内",@"国际",@"娱乐",@"体育",@"军事",@"科技",@"财经",@"时尚"] mutableCopy];
    }
    return self;
}
#pragma mark-初始化
//設定用戶界面
- (void)setUpUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake(110, 150);
    
    //2.初始化collectionView
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 76) collectionViewLayout:layout];
    [self.view addSubview:_mainCollectionView];
    _mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [_mainCollectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    //4.设置代理
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    
   
    
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
    NSDictionary * topNews = @{@"type":TOP,@"key":KEY};
    [NetRequst GET:BASEURL parameters:topNews success:^(id responseObject) {
        _SDArray = responseObject[@"result"][@"data"];
        
        for (id dic in _SDArray)
        {
            NSString * imageURL = dic[@"thumbnail_pic_s"];
            NSString * titleInfo = dic[@"title"];
            if (_imageURLArr.count >= 8)
            {
                break;
            }
            else
            {
                [_imageURLArr addObject:imageURL];
                [_titleLabelArr addObject:titleInfo];
            }
        }
        _SDCarouselImageScrollView.titlesGroup = _titleLabelArr;
        _SDCarouselImageScrollView.imageURLStringsGroup = _imageURLArr;
        
    } failure:^(NSError *error) {
         NSLog(@"error=%@",error);
    }];
    
    
}
#pragma mark-協議
#pragma mark-SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
        WebViewController * webView = [[WebViewController alloc]init];
        webView.detailURL = _SDArray[index][@"url"];
        webView.detailTitle = _SDArray[index][@"title"];
        webView.detailImage = _SDArray[index][@"thumbnail_pic_s"];
        webView.author_name = _SDArray[index][@"author_name"];
        webView.author_name = _SDArray[index][@"date"];
    
        [self.navigationController pushViewController:webView animated:YES];
}

#pragma mark-UICollectionViewDataSource
//返回section個數
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//返回每個section的item個數
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _CollectionDataSource.count;
}
//配置collectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * cell = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.botLabel.text = _CollectionDataSource[indexPath.row];
    cell.topImage.image = [UIImage imageNamed:_CollectionDataSource[indexPath.row]];
    return cell;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 130);
}



//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 300);
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    //headerView.backgroundColor =[UIColor grayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, headerView.bounds.size.width, 50)];
    label.text = @"资讯类别";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    [headerView addSubview:label];
    [headerView addSubview:self.SDCarouselImageScrollView];
    return headerView;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    InfoViewController * infoVC = [[InfoViewController alloc]init];
    infoVC.InfoTitle = _CollectionDataSource[indexPath.row];
    infoVC.index = indexPath.row;
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem=back;

    [self.navigationController pushViewController:infoVC animated:YES];
}




#pragma mark-懶加載
- (SDCycleScrollView *)SDCarouselImageScrollView
{
    if (!_SDCarouselImageScrollView) {
        _SDCarouselImageScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250) imageURLStringsGroup:_imageURLArr];
        _SDCarouselImageScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
        _SDCarouselImageScrollView.titlesGroup = _titleLabelArr;
        _SDCarouselImageScrollView.imageURLStringsGroup = _imageURLArr;
        _SDCarouselImageScrollView.titleLabelHeight = 55;
        _SDCarouselImageScrollView.showPageControl = YES;
        _SDCarouselImageScrollView.titleLabelTextFont = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        _SDCarouselImageScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _SDCarouselImageScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _SDCarouselImageScrollView.delegate = self;
    }
    return _SDCarouselImageScrollView;
}
@end
