//
//  QSRefreshTableViewWithMAMAAnimation.m
//  TTMM
//
//  Created by xue on 16/11/12.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import "QSRefreshTableViewWithMAMAAnimation.h"
@implementation QSRefreshTableViewWithMAMAAnimation

- (instancetype)initWithFrame:(CGRect)frame
                        style:(UITableViewStyle)style
                      withTag:(NSInteger)tag
                 withDelegate:(id)delegate
                 withCellName:(NSString *)cellName
                withRowHeight:(CGFloat)rowHeight
          withReuseIdentifier:(NSString *)reuseIdentifier
             withRefreshBlock:(RefreshLoadMoreBlock)refresh
            withLoadMoreBlock:(RefreshLoadMoreBlock)loadMore
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        self.tag = tag;
        self.dataSource = delegate;
        self.delegate = delegate;
        //註冊cell設置identifier
        [self registerClass:NSClassFromString(cellName) forCellReuseIdentifier:reuseIdentifier];
        self.rowHeight = rowHeight;
        if (refresh)
        {
            MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
                refresh(self);
            }];
            // Hide the time
            header.lastUpdatedTimeLabel.hidden = YES;
            
            // Hide the status
            header.stateLabel.hidden = YES;
            NSMutableArray *idleImages = [NSMutableArray array];
            for (NSUInteger i = 1; i<=16; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", i]];
                image = [self scaleImage:image toScale:0.25];
                [idleImages addObject:image];
            }
            
            
            
            [header setImages:idleImages forState:MJRefreshStateIdle];
            
            [header setImages:idleImages forState:MJRefreshStatePulling];
            
            [header setImages:idleImages forState:MJRefreshStateRefreshing];
            
            self.mj_header = header;
            
            
            
            
            
        }
        if (loadMore)
        {
            
            
            NSMutableArray *idleImages = [NSMutableArray array];
            for (NSUInteger i = 1; i<=16; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", i]];
                image = [self scaleImage:image toScale:0.25];
                [idleImages addObject:image];
            }
            
            MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
                loadMore(self);
            }];
            footer.refreshingTitleHidden = YES;
            
            [footer setImages:idleImages forState:MJRefreshStateRefreshing];
            
            
            self.mj_footer = footer;
            
            
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame /**< 註冊cell時使用xib佈局*/
                        style:(UITableViewStyle)style
                      withTag:(NSInteger)tag
                 withDelegate:(id)delegate
              withCellXIBName:(NSString *)cellXIBName
                withRowHeight:(CGFloat)rowHeight
          withReuseIdentifier:(NSString *)reuseIdentifier
             withRefreshBlock:(RefreshLoadMoreBlock)refresh
            withLoadMoreBlock:(RefreshLoadMoreBlock)loadMore
{
    
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        self.tag = tag;
        self.dataSource = delegate;
        self.delegate = delegate;
        //註冊cell設置identifier
        [self registerNib:[UINib nibWithNibName:cellXIBName bundle:nil] forCellReuseIdentifier:reuseIdentifier];
        self.rowHeight = rowHeight;
        if (refresh)
        {
            //            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //                refresh(self);
            //            }];
            
            
            
            MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
                refresh(self);
            }];
            // Hide the time
            header.lastUpdatedTimeLabel.hidden = YES;
            
            // Hide the status
            header.stateLabel.hidden = YES;
            NSMutableArray *idleImages = [NSMutableArray array];
            for (NSUInteger i = 1; i<=16; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", i]];
                image = [self scaleImage:image toScale:0.25];
                [idleImages addObject:image];
            }
            
            
            
            [header setImages:idleImages forState:MJRefreshStateIdle];
            
            [header setImages:idleImages forState:MJRefreshStatePulling];
            
            [header setImages:idleImages forState:MJRefreshStateRefreshing];
            
            self.mj_header = header;
            
            
            
            
            
        }
        if (loadMore)
        {
            
            
            NSMutableArray *idleImages = [NSMutableArray array];
            for (NSUInteger i = 1; i<=16; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", i]];
                image = [self scaleImage:image toScale:0.25];
                [idleImages addObject:image];
            }
            
            MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
                loadMore(self);
            }];
            footer.refreshingTitleHidden = YES;
            
            [footer setImages:idleImages forState:MJRefreshStateRefreshing];
            
            
            self.mj_footer = footer;
            
            
        }
    }
    return self;
    
    
    
}


- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width *
                                           scaleSize, image.size.height * scaleSize));
    
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize,image.size.height * scaleSize)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return scaledImage;
    
}


@end
