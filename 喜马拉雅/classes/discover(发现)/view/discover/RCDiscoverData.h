//
//  RCDiscoverData.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCCatrgory,RCFocusImage,RCLatestSpecial,RCLatestActivity,RCRecommendAlbums,RCTopCategory;
@interface RCDiscoverData : NSObject
/**
 *  "ret": 0,
 "focusImages": {},
 "categories": {},
 "latest_special": {},
 "latest_activity": {},
 "latest_xzone_post": "中国版失乐园( 记录那段不堪回首的错爱)",
 "recommendAlbums": {}
 */
@property(nonatomic,assign) int ret;
@property(nonatomic,copy) NSString  *latest_xzone_post;
@property(nonatomic,strong) RCCatrgory  *categories;
@property(nonatomic,strong) RCFocusImage  *focusImages;
@property(nonatomic,strong) RCLatestSpecial  *latest_special;
@property(nonatomic,strong) RCLatestActivity  *latest_activity;
@property(nonatomic,strong) RCRecommendAlbums  *recommendAlbums;

@end
