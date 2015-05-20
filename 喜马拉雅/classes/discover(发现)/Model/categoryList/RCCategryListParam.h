//
//  RCCategryListParam.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCCategryListParam : NSObject
/**
 *  device=android&per_page=100&category=all&type=album&page=1
 */
@property(nonatomic,copy) NSString  *device;
@property(nonatomic,copy) NSString  *category;
@property(nonatomic,copy) NSString  *type;
@property(nonatomic,strong) NSNumber  *per_page;
@property(nonatomic,strong) NSNumber  *page;
+ (instancetype)param;
@end
