//
//  RCComment.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCComment.h"
#import "RCOneComment.h"
#import "RCOneParentComment.h"
#import "MJExtension.h"
@implementation RCComment
+ (NSDictionary *)objectClassInArray{
    return @{@"comments":[RCOneComment class],@"parentComments":[RCOneParentComment class]};
}
@end
