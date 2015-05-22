//
//  RChotActivity.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCHotActivity : NSObject
/**
 *    "activityId": 137,
 "coverPathLarge": "http://fdfs.xmcdn.com/group14/M0B/07/99/wKgDZFVdOUyQZfwGAAGhO2jYsq4706_mobile_medium.jpg",
 "activityStatus": 2,
 "isHot": true,
 "title": "520告白日 错过就是一辈子！"
 */
@property(nonatomic,copy) NSString  *coverPathLarge;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,strong) NSNumber  *activityId;
@property(nonatomic,strong) NSNumber  *activityStatus;
@property(nonatomic,assign) BOOL isHot;

@end
