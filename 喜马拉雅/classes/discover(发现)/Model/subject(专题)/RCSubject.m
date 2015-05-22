//
//  RCSubject.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSubject.h"
#import "RCSubjectList.h"
#import "MJExtension.h"
@implementation RCSubject
+ (NSDictionary *)objectClassInArray{

    return @{@"list":[RCSubjectList class]};
}
@end
