//
//  RCTrack.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCTrack.h"
#import "RCTrackList.h"
#import "MJExtension.h"
@implementation RCTrack
+ (NSDictionary *)objectClassInArray{

    return @{@"list":[RCTrackList class]};
}
@end
