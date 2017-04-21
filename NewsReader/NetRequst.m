//
//  NetRequst.m
//  網絡請求2
//
//  Created by xuehangzhou on 16/9/22.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import "NetRequst.h"
#import "AFNetworking.h"
#import "APIConfig.h"
@implementation NetRequst
+(void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //規定請求超時時間
    manager.requestSerializer.timeoutInterval = 8;
    //配置請求格式，二進制
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //需要擴展的響應類型 放進NSSET
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"application/json",
                                                         @"text/json",
                                                         @"text/javascript",
                                                         @"text/html", nil];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//有數據執行成功的Block
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //數據請求失敗的Block
        failure(error);
    }];


}
+(void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //規定請求超時時間
    manager.requestSerializer.timeoutInterval = 8;
    //配置請求格式，二進制
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //需要擴展的響應類型 放進NSSET
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                         @"application/json",
                                                         @"text/json",
                                                         @"text/javascript",
                                                         @"text/html", nil];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //有數據執行成功的Block
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //數據請求失敗的Block
        failure(error);
    }];
}
@end
