//
//  RCconditionOfAllUserDoc.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCconditionOfAllUserDoc : NSObject
/**
 *    "webDistribute": 0,
 "mobileDistribute": 0,
 "uid": 4476035,
 "smallPic": "http://fdfs.xmcdn.com/group5/M09/24/1E/wKgDtVSqXDLSOid5AAFAAI6n6Vw744_mobile_small.jpg",
 "mobileCopyright": 0,
 "isVerified": "true",
 "nickname": "青雪故事2010",
 "logoPic": "group5/M09/24/1E/wKgDtVSqXDLSOid5AAFAAI6n6Vw744.jpg",
 "intro": "【惊悚故事，好书好听】新浪官微\"青雪故事2010\"；微信公众号\"青雪故事\"（因有同名假号，请搜索唯一微信号“qingxuegushi2014”）",
 "last_update": 1432546961000,
 "personDescribe": "惊悚故事，好书好听",
 "updated_at": 1432852200000,
 "create_time": 1385050787000,
 "gender": "女",
 "isLoginBan": "false",
 "pTtitle": "吉林省人民广播电台主播",
 "webCopyright": 0,
 "is_follow": false,
 "be_followed": false,
 "tracks_counts": 530,
 "followers_counts": 1381381,
 "followings_counts": 76
 */
@property(nonatomic,strong) NSNumber  *mobileDistribute;
@property(nonatomic,strong) NSNumber  *webDistribute;
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *updated_at;
@property(nonatomic,strong) NSNumber  *create_time;
@property(nonatomic,strong) NSNumber  *webCopyright;
@property(nonatomic,strong) NSNumber  *tracks_counts;
@property(nonatomic,strong) NSNumber  *followers_counts;
@property(nonatomic,strong) NSNumber  *followings_counts;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *logoPic;
@property(nonatomic,copy) NSString  *smallPic;
@property(nonatomic,copy) NSString  *intro;
@property(nonatomic,copy) NSString  *personDescribe;
@property(nonatomic,copy) NSString  *gender;
@property(nonatomic,copy) NSString  *pTtitle;
@property(nonatomic,assign) BOOL isVerified;
@property(nonatomic,assign) BOOL isLoginBan;
@property(nonatomic,assign) BOOL is_follow;
@property(nonatomic,assign) BOOL be_followed;

@end
