//
//  RCCategoryFocusImageParam.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCCategoryFocusImageParam : NSObject
/**
 *      // categoryId=3&version=3.25.7.1&device=android

 */
@property(nonatomic,strong) NSNumber  *categoryId;
@property(nonatomic,copy) NSString  *version;
@property(nonatomic,copy) NSString  *device;

@end
