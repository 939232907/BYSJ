//
//  QSVideoCell.h
//  TTMM
//
//  Created by xue on 16/11/17.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QSVideoCell;
@protocol QSVideoCellDelegate <NSObject>
@optional
- (void)QSVideoCellPlayDelegateClick:(NSDictionary *)dataDict Cell:(QSVideoCell *)cell;
@end
@interface QSVideoCell : UITableViewCell

@property (nonatomic,strong)UIImageView * videoImageView;
@property (nonatomic,strong) NSDictionary   * dataDict;         //数据字典
@property (nonatomic,assign)NSInteger tableViewIndex;
@property (nonatomic,strong) NSIndexPath    * indexPath;        //cell indexPath


@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * infoLabel;
@property (nonatomic,strong)UIView * thinLineView;
@property (nonatomic,strong)UIView * fatLineView;
@property (nonatomic,strong)UIButton * playButton;



@property (nonatomic,strong)UIViewController * Cellcontroller;
@property(nonatomic,weak) id<QSVideoCellDelegate> delegate;
@property (nonatomic,strong)UIButton * shareButton;
@property (nonatomic,strong)UIButton * loveButton;
@property (nonatomic,strong)UIButton * goodButton;
@property (nonatomic,strong)UILabel * goodNumberLabel;
@property (nonatomic,strong)UILabel * talkNumberLabel;
@property (nonatomic,strong)UIButton * talkButton;
@property (nonatomic,strong)UIButton * kindButton;
@property (nonatomic,strong)NSMutableArray * dataSource;
@property (nonatomic,strong)UIViewController *lastVC; // 上级响应页面

//
//-(void)setData:(NSDictionary *)dict{
//    
//    dict[@"isPlay"] = YES;
//    
//}


@end
