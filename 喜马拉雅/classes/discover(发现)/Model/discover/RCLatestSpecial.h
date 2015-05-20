//
//  RCLatestSpecial.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCLatestSpecial : NSObject
/**
 *   "title": "80后心目中的乐坛女神",
 "coverPathSmall": "http://fdfs.xmcdn.com/group15/M00/05/63/wKgDZVVVtYXCUm8wAABz3fH0uL0504.jpg",
 "coverPathBig": "http://fdfs.xmcdn.com/group7/M02/05/57/wKgDWlVVsu3wQeNbAAJltcbI6K0385_mobile_medium.jpg",
 "isHot": false
 */
@property(nonatomic,copy) NSString  *title;
@property(nonatomic,copy) NSString  *coverPathSmall;
@property(nonatomic,copy) NSString  *coverPathBig;
@property(nonatomic,assign) BOOL isHot;

@end
