//
//  NetRequst.h
//  網絡請求2
//
//  Created by xuehangzhou on 16/9/22.
//  Copyright © 2016年 清水科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequst : NSObject
//GET
+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//POST
+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
