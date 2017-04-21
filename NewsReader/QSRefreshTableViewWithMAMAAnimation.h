//
//  QSRefreshTableViewWithMAMAAnimation.h
//  TTMM
//
//  Created by xue on 16/11/12.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
typedef void(^RefreshLoadMoreBlock)(UITableView * sender);
@interface QSRefreshTableViewWithMAMAAnimation : UITableView
- (instancetype)initWithFrame:(CGRect)frame /**< 註冊cell時使用手寫佈局*/
                        style:(UITableViewStyle)style
                      withTag:(NSInteger)tag
                 withDelegate:(id)delegate
                 withCellName:(NSString *)cellXIBName
                withRowHeight:(CGFloat)rowHeight
          withReuseIdentifier:(NSString *)reuseIdentifier
             withRefreshBlock:(RefreshLoadMoreBlock)refresh
            withLoadMoreBlock:(RefreshLoadMoreBlock)loadMore;
- (instancetype)initWithFrame:(CGRect)frame /**< 註冊cell時使用xib佈局*/
                        style:(UITableViewStyle)style
                      withTag:(NSInteger)tag
                 withDelegate:(id)delegate
                 withCellXIBName:(NSString *)cellName
                withRowHeight:(CGFloat)rowHeight
          withReuseIdentifier:(NSString *)reuseIdentifier
             withRefreshBlock:(RefreshLoadMoreBlock)refresh
            withLoadMoreBlock:(RefreshLoadMoreBlock)loadMore;
@end
