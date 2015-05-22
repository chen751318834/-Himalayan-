//
//  RCRecommendPoster.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCRecommendPoster : NSObject
/**
 *  "uid": 18265877,
 "nickname": "Margaret_46",
 "smallLogo": "http://fdfs.xmcdn.com/group5/M06/D6/E9/wKgDtVSJTKDimR_BAACAXNYIdAA404.jpg"
 */
@property(nonatomic,strong) NSNumber  *uid;
@property(nonatomic,copy) NSString  *nickname;
@property(nonatomic,copy) NSString  *smallLogo;


@end
