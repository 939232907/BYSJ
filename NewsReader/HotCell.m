//
//  HotCell.m
//  NewsReader
//
//  Created by xue on 2017/4/21.
//  Copyright © 2017年 薛航舟. All rights reserved.
//

#import "HotCell.h"

@implementation HotCell

- (void)setUpUI
{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, -5, [UIScreen mainScreen].bounds.size.width - 10, 40)];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor blackColor];
    //_titleLabel.backgroundColor = [UIColor yellowColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _infoImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, [UIScreen mainScreen].bounds.size.width - 20, 180)];
    _infoImage.backgroundColor = [UIColor redColor];
    [self addSubview:_infoImage];
    
    _authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 215, [UIScreen mainScreen].bounds.size.width * 0.45 - 20, 20)];
    _authorLabel.font = [UIFont systemFontOfSize:13];
    _authorLabel.textColor = [UIColor grayColor];
    //_authorLabel.backgroundColor = [UIColor greenColor];
    _authorLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_authorLabel];
    
    _dateTime = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.width * 0.45, 215, [UIScreen mainScreen].bounds.size.width * 0.45 - 10, 20)];
    _dateTime.font = [UIFont systemFontOfSize:13];
    _dateTime.textColor = [UIColor grayColor];
    //_dateTime.backgroundColor = [UIColor greenColor];
    _dateTime.textAlignment = NSTextAlignmentRight;
    [self addSubview:_dateTime];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

@end
