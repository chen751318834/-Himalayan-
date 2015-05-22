//
//  RCRecommendOwnerZone.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCRecommendOwnerZone : NSObject
/**
 *   "uid": 1721964,
 "nickname": "我是王掌柜",
 "smallLogo": "http://fdfs.xmcdn.com/group6/M0B/8E/6B/wKgDg1UBaB6zqyoCAASz3Oeqh3k512.png"
 */
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *smallLogo;


@end
