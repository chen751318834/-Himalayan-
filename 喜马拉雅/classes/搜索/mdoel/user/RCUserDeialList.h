//
//  RCUserDeialList.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/11.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCUserDeialList : NSObject
/**
 *              "uid": 1012757,
 "nickname": "喜马拉雅好声音",
 "isVerified": true,
 "smallLogo": "http://fdfs.xmcdn.com/group6/M09/3C/E7/wKgDg1TirgqicVIrAABP8QKFdUw233_mobile_small.jpg",
 "isFollowed": false,
 "isFollowing": false,
 "followers": 19299545,
 "tracks": 153,
 "followedTime": 1428636214000,
 "ptitle": "分享好声音，发现好声音",
 "personDescribe": "分享好声音，发现好声音"
 */
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *followers;
@property(nonatomic,strong) NSNumber  *tracks;
@property(nonatomic,strong) NSNumber  *followedTime;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *smallLogo;
@property(nonatomic,copy) NSString  *ptitle;
@property(nonatomic,copy) NSString  *personDescribe;
@property(nonatomic,assign) BOOL isVerified;
@property(nonatomic,assign) BOOL isFollowed;
@property(nonatomic,assign) BOOL isFollowing;

@end
