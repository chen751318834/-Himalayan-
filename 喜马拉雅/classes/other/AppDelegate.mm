//
//  AppDelegate.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "AppDelegate.h"
#import "RCTabBarViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

#import "RCConst.h"
#import "RCplayerStatus.h"
#import "AFSoundManager.h"
#import "UMSocialQQHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[RCTabBarViewController alloc]init];
    [self.window makeKeyAndVisible];
    [UMSocialData setAppKey:@"5579482367e58ee727000ae0"];
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"5579482367e58ee727000ae0" url:@"http://www.umeng.com/social"];


    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    [RCplayerStatus sharedplayerStatus].applicationEnterBackground = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:RCPlayerViewSetSongInformationNotification object:nil userInfo:nil];
}

@end
