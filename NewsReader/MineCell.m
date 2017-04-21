//
//  MineCell.m
//  NewsReader
//
//  Created by xue on 2017/4/22.
//  Copyright © 2017年 薛航舟. All rights reserved.
//

#import "MineCell.h"
#import "Adaption.h"
@implementation MineCell

- (void)setUpUI
{
    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 25, 25)];
    //_iconImageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 8, 200, 50)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = AAFont(30);
    _titleLabel.textColor = [UIColor blackColor];
    [self addSubview:_titleLabel];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
