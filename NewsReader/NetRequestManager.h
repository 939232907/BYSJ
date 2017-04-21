//
//  NetRequestManager.h
//  THMM2
//
//  Created by zhengbing on 2016/11/9.
//  Copyright © 2016年 zhengbing. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "NSDictionary+BFKit.h"
#import "AFNetworking.h"
typedef void(^Success)(id response);
typedef void(^Failed)(NSError *error);
@interface NetRequestManager : NSObject
//+ (void)postMethod:(NSString *)method withAction:(NSString *)action withParameters:(NSDictionary *)parameterDic withSuccess:(Success)success withFailed:(Failed)failed;
+ (void)postCateG:(NSString *)G method:(NSString *)method action:(NSString *)action paramters:(NSDictionary *)paramters success:(Success)success failure:(Failed)failure;
@end
