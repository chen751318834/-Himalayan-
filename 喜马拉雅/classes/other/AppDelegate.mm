//
//  AppDelegate.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "AppDelegate.h"
#import "RCTabBarViewController.h"
#import "RCConst.h"
#import "RCplayerStatus.h"
#import "AFSoundManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[RCTabBarViewController alloc]init];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    [RCplayerStatus sharedplayerStatus].applicationEnterBackground = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:RCPlayerViewSetSongInformationNotification object:nil userInfo:nil];
}

@end
