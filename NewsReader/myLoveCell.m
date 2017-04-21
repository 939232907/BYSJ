//
//  myLoveCell.m
//  zaker
//
//  Created by xuehangzhou on 16/9/23.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import "myLoveCell.h"

@implementation myLoveCell

- (void)setUpUI
{
    _myLoveCellImage  = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 90)];
    //_myLoveCellImage.backgroundColor = [UIColor yellowColor];
    _myLoveCellImage.layer.cornerRadius = 5;
    _myLoveCellImage.layer.borderWidth = 2;
    _myLoveCellImage.layer.borderColor = [UIColor grayColor].CGColor;
    _myLoveCellImage.layer.shadowColor = [UIColor grayColor].CGColor;
    _myLoveCellImage.layer.shadowOffset = CGSizeMake(1, 1);
    _myLoveCellImage.layer.shadowOpacity = 1;
    _myLoveCellImage.layer.shadowOpacity = YES;
    [self addSubview:_myLoveCellImage];

    _MyloveCellTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 20, 250, 60)];
    //_MyloveCellTitleLabel.backgroundColor = [UIColor greenColor];
    _MyloveCellTitleLabel.font = [UIFont systemFontOfSize:16];
    _MyloveCellTitleLabel.numberOfLines = 0;
    [self addSubview:_MyloveCellTitleLabel];

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
