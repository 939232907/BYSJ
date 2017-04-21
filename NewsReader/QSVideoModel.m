//
//  QSVideoModel.m
//  TTMM
//
//  Created by xue on 16/11/17.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import "QSVideoModel.h"

@implementation QSVideoModel
+ (NSArray *)QSVideoModelFromJSONArray:(NSMutableArray *)array
{
    NSMutableArray * modelArray = [NSMutableArray array];
    for (NSDictionary * dict in array)
    {
        QSVideoModel * QSVM = [[QSVideoModel alloc]init];
        [QSVM setValuesForKeysWithDictionary:dict];
        QSVM.isPlay = NO;
        
        [modelArray addObject:QSVM];
    }
    return modelArray;
}
@end
