//
//  RCDiscoverDataTool.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCDiscoverDataTool.h"
#import "RCNetWorkingTool.h"
#import "MJExtension.h"
#import "RCCategoryFocusImageParam.h"
#import "RCCategoryFocusImageResult.h"
#import "RCCategryListParam.h"
#import "RCCategoryListResult.h"
@implementation RCDiscoverDataTool
+ (void)categoryListWithParam:(RCCategryListParam *)param success:(void (^)(RCCategoryListResult *))success failure:(void (^)(NSError *))failure{
    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/m/category_tag_list" params:param.keyValues success:^(id json) {
        RCCategoryListResult * result = [RCCategoryListResult objectWithKeyValues:json];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)categoryFocusImageWithParam:(RCCategoryFocusImageParam *)param success:(void (^)(RCCategoryFocusImageResult *))success failure:(void (^)(NSError *))failure{

    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/m/category_focus_image" params:param.keyValues success:^(id json) {
        RCCategoryFocusImageResult * result = [RCCategoryFocusImageResult objectWithKeyValues:json];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end


