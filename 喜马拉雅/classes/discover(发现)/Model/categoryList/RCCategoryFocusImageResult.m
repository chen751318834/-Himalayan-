//
//  RCCategoryFocusImageResult.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCCategoryFocusImageResult.h"
#import "MJExtension.h"
#import "RCList.h"
@implementation RCCategoryFocusImageResult
+ (NSDictionary *)objectClassInArray{

    return  @{@"list":[RCList class]};
}
@end
