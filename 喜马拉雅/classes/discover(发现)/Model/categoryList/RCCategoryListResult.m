//
//  RCCategoryListResult.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCCategoryListResult.h"
#import "MJExtension.h"
#import "RCCategoryList.h"
@implementation RCCategoryListResult
+ (NSDictionary *)objectClassInArray{

    return @{@"list":[RCCategoryList class]};
}
@end
