//
//  RCplayerUserInfo.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/2.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCplayerUserInfo : NSObject
/**
 *   "uid": 1412917,
 "nickname": "罗辑思维脱口秀",
 "isVerified": true,
 "smallLogo": "http://fdfs.xmcdn.com/group5/M07/4A/35/wKgDtlS4cmeAM8R4AAC2jG7vGBo443_mobile_small.jpg",
 "isFollowed": false,
 "followers": 3946929,
 "followings": 32,
 "tracks": 122,
 "albums": 2,
 "ptitle": "知识中寻找独立见识",
 "personDescribe": "知识中寻找独立见识"
 */
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *followers;
@property(nonatomic,strong) NSNumber  *followings;
@property(nonatomic,strong) NSNumber  *tracks;
@property(nonatomic,strong) NSNumber  *albums;
@property(nonatomic,assign) BOOL isVerified;
@property(nonatomic,assign) BOOL isFollowed;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *smallLogo;
@property(nonatomic,copy) NSString  *ptitle;
@property(nonatomic,copy) NSString  *personDescribe;


@end
