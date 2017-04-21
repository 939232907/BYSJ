//
//  NetRequestManager.m
//  THMM2
//
//  Created by zhengbing on 2016/11/9.
//  Copyright © 2016年 zhengbing. All rights reserved.
//

#import "NetRequestManager.h"
//支持GET和POST提交
//测试环境接口地址：
#define BASEURL @"http://test.thclub.cn/mobile_api.php"
//生产环境接口地址：
//#define BASEURL @"http://xxxx.cn/mobile_api.php"


@implementation NetRequestManager

  //[self postCateG:@"" method:@"article_favourites" action:@"getDailyFavourites" paramters:@{} success:success failure:failure];
+ (void)postCateG:(NSString *)G method:(NSString *)method action:(NSString *)action paramters:(NSDictionary *)paramters success:(Success)success failure:(Failed)failure
{
    NSMutableDictionary *muDict = [NSMutableDictionary dictionary];
    muDict[@"g"] = G;
    muDict[@"m"] = method;
    muDict[@"a"] = action;
    //NSLog(@"sUserid = %@",singleTool.sUserid);
    muDict[@"params"] = [paramters dictionaryToJSON];
    muDict[@"phoneType"] = @"iphone";
    muDict[@"channelId"] = @"1000001";
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
    [manager POST:BASEURL parameters:muDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

    
}
//+ (void)postMethod:(NSString *)method withAction:(NSString *)action withParameters:(NSDictionary *)parameterDic withSuccess:(Success)success withFailed:(Failed)failed
//{
//    
//    // 请求参数
//    NSMutableDictionary *muDict = [NSMutableDictionary dictionary];
//    muDict[@"m"] = method;
//    muDict[@"a"] = action;
//    muDict[@"params"] = [parameterDic dictionaryToJSON];
//    muDict[@"phoneType"] = @"iphone";
//    muDict[@"channelId"] = @"1000001";
//    
//    
//
////    if (登陸以後)
////    {
////        muDict[@"sid"] = [abc share].sid;
////    }
//    
//    
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer.timeoutInterval = 10;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
//     [manager POST:BASEURL parameters:muDict progress:^(NSProgress * _Nonnull uploadProgress) {
//         
//     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//         success(responseObject);
//     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//         failed(error);
//     }];
//}


@end
