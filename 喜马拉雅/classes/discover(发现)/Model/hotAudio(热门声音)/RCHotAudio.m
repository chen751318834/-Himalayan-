//
//  RCHotAudio.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCHotAudio.h"
#import "RCOnneHotAudio.h"
#import "MJExtension.h"
@implementation RCHotAudio
+ (NSDictionary *)objectClassInArray{
    return @{@"list":[RCOnneHotAudio class]};
}
@end

