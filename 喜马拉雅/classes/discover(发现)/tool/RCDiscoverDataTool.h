//
//  RCDiscoverDataTool.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCCategryListParam,RCCategoryListResult,RCCategoryFocusImageParam,RCCategoryFocusImageResult;
@interface RCDiscoverDataTool : NSObject
/**
 *  获取分类数据
 *
 */
+ (void)categoryListWithParam:(RCCategryListParam *)param success:(void (^)(RCCategoryListResult * result))success failure:(void (^)(NSError *error))failure;
//category_focus_image
/**
 *  获取图片数据
 *
 *  @param param
 *  @param success
 *  @param failure 
 */
+ (void)categoryFocusImageWithParam:(RCCategoryFocusImageParam *)param success:(void (^)(RCCategoryFocusImageResult * result))success failure:(void (^)(NSError *error))failure;
@end
