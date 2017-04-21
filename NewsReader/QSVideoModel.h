//
//  QSVideoModel.h
//  TTMM
//
//  Created by xue on 16/11/17.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 sUserid = "40";
 sComTotal = "0";
 sAvatar = "http://test.thclub.cn/data/upload/admin_user/000/00/00/d645920e395fedad7bbbed0eca3fe2e0_100.jpg";
 sVideoUrl = "";
 sTitle = "莓子们熟了，夏天超级水果";
 sCateid = "74";
 sIntro = "莓子们熟了，夏天超级水果";
 sThumb = "http://test.thclub.cn/data/upload/article/1607/02/577743ff41acd_thumb.jpg";
 sId = "377";
 sAddtime = "1467433245";
 sShareurl = "http://test.thclub.cn/index.php?m=article&a=info&id=377";
 sZanTotal = "0";
 sCollectTotal = "1";
 sIsCollect = 0;
 sUsername = "爱读童书妈妈";
 sHitnum = "33";
 sCatename = "爱尚厨房";
 sIsVideo = "0"
 */
@interface QSVideoModel : NSObject
@property (nonatomic,strong)NSString * sUserid;
@property (nonatomic,strong)NSString * sComTotal;
@property (nonatomic,strong)NSString * sAvatar;
@property (nonatomic,strong)NSString * sVideoUrl;
@property (nonatomic,strong)NSString * sTitle;
@property (nonatomic,strong)NSString * sCateid;
@property (nonatomic,strong)NSString * sIntro;
@property (nonatomic,strong)NSString * sThumb;
@property (nonatomic,strong)NSString * sId;
@property (nonatomic,strong)NSString * sAddtime;
@property (nonatomic,strong)NSString * sShareurl;
@property (nonatomic,strong)NSString * sZanTotal;
@property (nonatomic,strong)NSString * sCollectTotal;
@property (nonatomic,strong)NSString * sIsCollect;
@property (nonatomic,strong)NSString * sUsername;
@property (nonatomic,strong)NSString * sHitnum;
@property (nonatomic,strong)NSString * sCatename;
@property (nonatomic,strong)NSString * sIsVideo;

//是否播放
@property (nonatomic, assign) BOOL isPlay;

+ (NSArray *)QSVideoModelFromJSONArray:(NSMutableArray *)array;
@end
