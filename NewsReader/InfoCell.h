//
//  InfoCell.h
//  NewsReader
//
//  Created by xue on 2017/4/21.
//  Copyright © 2017年 薛航舟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoCell : UITableViewCell
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * authorLabel;
@property (nonatomic,strong)UIImageView * infoImage;
@property (nonatomic,strong)UILabel * dateTime;
@end
