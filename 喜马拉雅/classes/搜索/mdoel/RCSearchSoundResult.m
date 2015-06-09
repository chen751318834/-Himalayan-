//
//  RCSearchSoundResult.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSearchSoundResult.h"
#import "MJExtension.h"
#import "RCSearchResultList.h"
@implementation RCSearchSoundResult
+ (NSDictionary *)objectClassInArray{
    return @{@"list":[RCSearchResultList class]};
}
@end
