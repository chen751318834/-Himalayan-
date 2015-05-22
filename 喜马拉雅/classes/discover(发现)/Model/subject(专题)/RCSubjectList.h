//
//  RCSubjectList.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCSubjectList : NSObject
/**
 *       "specialId": 299,
 "title": "520+1314=毕业说爱你",
 "contentType": 2,
 "coverPathBig": "http://fdfs.xmcdn.com/group13/M0B/06/AA/wKgDXVVZtSjDnq-BAAGXPkm38cg523_mobile_medium.jpg",
 "releasedAt": 1431943225000,
 "isHot": false
 */
@property(nonatomic,copy) NSString  *coverPathBig;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,strong) NSNumber  *specialId;
@property(nonatomic,strong) NSNumber  *releasedAt;
@property(nonatomic,strong) NSNumber  *contentType;
@property(nonatomic,assign) BOOL isHot;

@end
