//
//  RCCategoryFocusImageList.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCCategoryFocusImageList : NSObject
/**
 *   "id": 2682,
 "shortTitle": "520浪漫婚礼歌单",
 "longTitle": "520浪漫婚礼歌单",
 "pic": "http://fdfs.xmcdn.com/group16/M06/06/A9/wKgDbFVZtomyTUVqAAETsDhE_ws272.jpg",
 "type": 3,
 "trackId": 6869351,
 "uid": 4078661
 */
@property(nonatomic,copy) NSString  *shortTitle;
@property(nonatomic,copy) NSString  *longTitle;
@property(nonatomic,copy) NSString  *pic;
@property(nonatomic,strong) NSNumber  *type;
@property(nonatomic,strong) NSNumber  *trackId;
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *ID;
@end
