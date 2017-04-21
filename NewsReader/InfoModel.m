//
//  InfoModel.m
//  NewsReader
//
//  Created by xue on 2017/4/21.
//  Copyright © 2017年 薛航舟. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel
+ (NSArray *)InfoModelArrayFromJSONArray:(NSArray *)JSONArray
{
    NSMutableArray * modelArray = [NSMutableArray array];
    for (NSDictionary * dict in JSONArray)
    {
        InfoModel * IM = [InfoModel new];
        [IM setValuesForKeysWithDictionary:dict];
        [modelArray addObject:IM];
    }
    return modelArray;
}
@end
