//
//  InfoModel.h
//  NewsReader
//
//  Created by xue on 2017/4/21.
//  Copyright © 2017年 薛航舟. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 category = "国内";
 thumbnail_pic_s = "http://06.imgmini.eastday.com/mobile/20170421/20170421183250_d95df9eb4b7870ab0c5ea8405ef5d98d_1_mwpm_03200403.jpeg";
 uniquekey = "a0adc0a27b23c02fc1eca989946ef97b";
 title = "青海玉树启动“虫癌”综合防治攻坚行动";
 date = "2017-04-21 18:32";
 author_name = "中国新闻网";
 thumbnail_pic_s03 = "http://06.imgmini.eastday.com/mobile/20170421/20170421183250_d95df9eb4b7870ab0c5ea8405ef5d98d_3_mwpm_03200403.jpeg";
 thumbnail_pic_s02 = "http://06.imgmini.eastday.com/mobile/20170421/20170421183250_d95df9eb4b7870ab0c5ea8405ef5d98d_2_mwpm_03200403.jpeg";
 url = "http://mini.eastday.com/mobile/170421183250482.html"
 */
@interface InfoModel : NSObject
@property (nonatomic,strong)NSString * category;
@property (nonatomic,strong)NSString * thumbnail_pic_s;
@property (nonatomic,strong)NSString * uniquekey;
@property (nonatomic,strong)NSString * title;
@property (nonatomic,strong)NSString * date;
@property (nonatomic,strong)NSString * author_name;
@property (nonatomic,strong)NSString * thumbnail_pic_s03;
@property (nonatomic,strong)NSString * thumbnail_pic_s02;
@property (nonatomic,strong)NSString * url;
+ (NSArray *)InfoModelArrayFromJSONArray:(NSArray *)JSONArray;
@end
