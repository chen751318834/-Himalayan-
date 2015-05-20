//
//  RCCategoryList.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCCategoryList.h"

@implementation RCCategoryList
- (NSString *)description{

    return [NSString stringWithFormat:@"%@---%@---%@",_tname,_cover_path,_category_id];
}
@end
