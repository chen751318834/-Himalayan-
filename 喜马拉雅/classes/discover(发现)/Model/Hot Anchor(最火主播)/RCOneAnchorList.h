//
//  RCOneAnchorList.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCOneAnchorList : NSObject
/**
 *  "uid": 1000202,
 "nickname": "郭德纲相声",
 "smallLogo": "http://fdfs.xmcdn.com/group1/M00/0B/3D/wKgDrlESHqyTqakZAADewk1yMt8360_web_x_large.jpg"
 */
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *smallLogo;

@end
