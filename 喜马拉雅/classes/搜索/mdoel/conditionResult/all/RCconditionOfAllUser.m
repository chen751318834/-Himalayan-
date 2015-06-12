//
//  RCconditionOfAllUser.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCconditionOfAllUser.h"
#import "RCconditionOfAllUserDoc.h"
#import "MJExtension.h"
@implementation RCconditionOfAllUser
+ (NSDictionary *)objectClassInArray{
    return @{@"docs":[RCconditionOfAllUserDoc class]};
}
@end
