//
//  QSVideoCell.m
//  TTMM
//
//  Created by xue on 16/11/17.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import "QSVideoCell.h"
#import "Adaption.h"
#import "Masonry.h"
#import "UIScreen+BFKit.h"
#import "UIImageView+WebCache.h"
#define KWIDTH ([[UIScreen mainScreen] bounds].size.width)
#define IMG_HEIGHT (KWIDTH * (9.0 / 16.0))
@interface QSVideoCell()
@end
@implementation QSVideoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView * bg = [[UIView alloc]  init];
        bg.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bg];
        
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(@0);
            make.bottom.equalTo(self.contentView).with.offset(-20);
        }];

        [self.contentView addSubview:self.videoImageView];
        
        
        UIButton * playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [playButton addTarget:self action:@selector(clickPlay) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:playButton];
        [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
            make.height.equalTo(self.videoImageView.mas_height);
        }];

        
        
//        _videoImageView = [[UIImageView alloc]initWithFrame:AAdaptionRect(0, 0, kBaseWidth, 400)];
//        _videoImageView.backgroundColor = [UIColor blackColor];
//        _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
//        _videoImageView.layer.masksToBounds = true;
//        
//        
//        //遮罩层
//        UIView * aView = [[UIView alloc] init];
//        aView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//        [_videoImageView addSubview:aView];
//        [aView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.bottom.equalTo(_videoImageView);
//        }];
//
//        
//        
//        UIImageView * imageView = [[UIImageView alloc] init];
//        //imageView.userInteractionEnabled = YES;
//        [imageView setImage:[UIImage imageNamed:@"开始播放.png"]];
//        [_videoImageView addSubview:imageView];
//        [imageView setBounds:CGRectMake(0, 0, 50, 50)];
//        [imageView setCenter:CGPointMake(SCREEN_WIDTH/2,IMG_HEIGHT/2)];
//
//        
//        
//        [self.contentView addSubview:self.videoImageView];
        
        
        
        
        
        _titleLabel = [[UILabel alloc]initWithFrame:AAdaptionRect(0, 240 / AAdaptionWidth(), kBaseWidth, 50)];
        //_titleLabel.backgroundColor = [UIColor grayColor];
        _titleLabel.text = @"重慶火鍋";
        _titleLabel.font = AAFont(35);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
       [self.contentView addSubview:_titleLabel];
        
        _infoLabel = [[UILabel alloc]initWithFrame:AAdaptionRect(10, 280 / AAdaptionWidth(), kBaseWidth - 20, 100)];
        _infoLabel.textAlignment = NSTextAlignmentLeft;
        //_infoTextView.text = @"sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss";
        //[_infoTextView sizeToFit];
        //_infoTextView.backgroundColor = [UIColor grayColor];
        //_infoLabel.backgroundColor = [UIColor redColor];
        _infoLabel.numberOfLines = 0;
        _infoLabel.font = AAFont(25);
        _infoLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_infoLabel];
        
//        _thinLineView = [[UIView alloc]initWithFrame:AAdaptionRect(0, 365 / AAdaptionWidth(), kBaseWidth, 3)];
//        _thinLineView.backgroundColor = [UIColor colorWithRed:236 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1.0];
//        [self.contentView addSubview:_thinLineView];
//        
//        _fatLineView = [[UIView alloc]initWithFrame:AAdaptionRect(0, 430 / AAdaptionWidth(), kBaseWidth, 40)];
//        _fatLineView.backgroundColor = [UIColor colorWithRed:236 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1.0];
//        [self.contentView addSubview:_fatLineView];
        

        
        
        
    }
    return self;
}






- (void)awakeFromNib {
    // Initialization code
      _dataSource = [NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark-協議


- (UIImageView *)videoImageView {
    if (_videoImageView!=nil){
        return _videoImageView;
    }
    _videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, IMG_HEIGHT)];
    //_videoImageView.userInteractionEnabled = YES;
    _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _videoImageView.layer.masksToBounds = true;
    _videoImageView.backgroundColor = [UIColor blackColor];
    
    //遮罩层
    UIView * aView = [[UIView alloc] init];
    aView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [_videoImageView addSubview:aView];
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(_videoImageView);
    }];
    
    
    UIImageView * imageView = [[UIImageView alloc] init];
    //imageView.userInteractionEnabled = YES;
    [imageView setImage:[UIImage imageNamed:@"开始播放.png"]];
    [_videoImageView addSubview:imageView];
    [imageView setBounds:CGRectMake(0, 0, 50, 50)];
    [imageView setCenter:CGPointMake(SCREEN_WIDTH/2,IMG_HEIGHT/2)];
    
    return _videoImageView;
}

- (void)clickPlay {
    if (self.delegate && [self.delegate respondsToSelector:@selector(QSVideoCellPlayDelegateClick:Cell:)]) {
        //通过代理方法 回传当前cell 对象
        [self.delegate QSVideoCellPlayDelegateClick:self.dataDict Cell:self];
    }
}
- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:[dataDict objectForKey:@"sThumb"]] placeholderImage:nil];
}

@end
