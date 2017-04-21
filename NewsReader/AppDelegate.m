//
//  AppDelegate.m
//  NewsReader
//
//  Created by xue on 2017/4/21.
//  Copyright © 2017年 薛航舟. All rights reserved.
//

#import "AppDelegate.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "TabViewController.h"
#import "myLoveViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    TabViewController *tab = (TabViewController *)self.window.rootViewController;
    if([shortcutItem.type isEqualToString:@"ONE"]){
        //        myLoveViewController *vc = [[myLoveViewController alloc] init];
        //        [tab.viewControllers[0] pushViewController:vc animated:YES];
        //初始化上下文对象
        LAContext* context = [[LAContext alloc] init];
        //错误对象
        NSError* error = nil;
        NSString* result = @"請輸入您的指紋！";
        
        //首先使用canEvaluatePolicy 判断设备支持状态
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            //支持指纹验证
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
                if (success) {
                    //验证成功，主线程处理UI
                    NSLog(@"OK!");
                    //                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"溫馨提示" message:@"驗證成功" preferredStyle:UIAlertControllerStyleAlert];
                    //                    UIAlertAction * sure = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //                                myLoveViewController *vc = [[myLoveViewController alloc] init];
                    //                                [tab.viewControllers[0] pushViewController:vc animated:YES];
                    //                    }];
                    //                    [alert addAction:sure];
                    //                    [tab presentViewController:alert animated:YES completion:nil];
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        myLoveViewController *vc = [[myLoveViewController alloc] init];
                        [tab.viewControllers[0] pushViewController:vc animated:YES];
                        
                        
                    }];
                }
                else
                {
                    NSLog(@"%@",error.localizedDescription);
                    switch (error.code) {
                        case LAErrorSystemCancel:
                        {
                            NSLog(@"Authentication was cancelled by the system");
                            //切换到其他APP，系统取消验证Touch ID
                            break;
                        }
                        case LAErrorUserCancel:
                        {
                            NSLog(@"Authentication was cancelled by the user");
                            //用户取消验证Touch ID
                            break;
                        }
                        case LAErrorUserFallback:
                        {
                            NSLog(@"User selected to enter custom password");
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                //用户选择输入密码，切换主线程处理
                                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"溫馨提示" message:@"為了安全zaker只能使用TouchID" preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction * sure = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                                    
                                }];
                                [alert addAction:sure];
                                [tab presentViewController:alert animated:YES completion:nil];
                            }];
                            break;
                        }
                        default:
                        {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                //其他情况，切换主线程处理
                                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"溫馨提示" message:@"驗證失敗" preferredStyle:UIAlertControllerStyleAlert];
                                UIAlertAction * sure = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                                    
                                }];
                                [alert addAction:sure];
                                [tab presentViewController:alert animated:YES completion:nil];
                            }];
                            break;
                        }
                    }
                }
            }];
        }
        else
        {
            //不支持指纹识别，LOG出错误详情
            
            switch (error.code) {
                case LAErrorTouchIDNotEnrolled:
                {
                    NSLog(@"TouchID is not enrolled");
                    break;
                }
                case LAErrorPasscodeNotSet:
                {
                    NSLog(@"A passcode has not been set");
                    break;
                }
                default:
                {
                    NSLog(@"TouchID not available");
                    break;
                }
            }
            
            NSLog(@"%@",error.localizedDescription);
        }
        
        
    }
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
