//
//  RCPlayerCommnet.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/3.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerCommnet.h"
#import "RCPlayerCommnetList.h"
#import "MJExtension.h"
@implementation RCPlayerCommnet
+ (NSDictionary *)objectClassInArray{

    return @{@"list":[RCPlayerCommnetList class]};
}
@end
