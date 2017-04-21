//
//  MyCollectionViewCell.m
//  UICollectionView
//
//  Created by xuehangzhou on 16/9/8.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import "MyCollectionViewCell.h"
@implementation MyCollectionViewCell
//重寫初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化頭部圖片
        _topImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 48, 48)];
        //_topImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_topImage];
        
        //初始化分塊標籤
        _botLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 70, 30)];
        _botLabel.textAlignment = NSTextAlignmentCenter;
        _botLabel.textColor = [UIColor blackColor];
        _botLabel.font = [UIFont systemFontOfSize:15];
        //_botLabel.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_botLabel];

    }
    return self;
}
@end
