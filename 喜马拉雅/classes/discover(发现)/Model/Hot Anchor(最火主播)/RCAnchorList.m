//
//  RCAnchorList.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAnchorList.h"
#import "MJExtension.h"
#import "RCOneAnchorList.h"
@implementation RCAnchorList
+ (NSDictionary *)replacedKeyFromPropertyName{

     return  @{@"ID":@"id"};
}
+ (NSDictionary *)objectClassInArray{

    return @{@"list":[RCOneAnchorList class]};
}
@end
