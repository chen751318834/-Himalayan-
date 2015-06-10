//
//  RCList.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCList : NSObject
/**
 *   "id": 2696,
 "shortTitle": "专栏精粹：为什么赚钱的地方都有中国大妈？",
 "longTitle": "专栏精粹：为什么赚钱的地方都有中国大妈？",
 "pic": "http://fdfs.xmcdn.com/group11/M0A/07/1D/wKgDbVVa3b7Aeva9AAGykzRDfy0125.jpg",
 "type": 3,
 "trackId": 6886751,
 "uid": 15450066
 */
@property(nonatomic,copy) NSString  *pic;
@property(nonatomic,copy) NSString  *shortTitle;
@property(nonatomic,copy) NSString  *longTitle;
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSNumber  *type;
@property(nonatomic,strong) NSNumber  *trackId;
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,strong) NSNumber  *playsCounts;
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *coverSmall;

@end
