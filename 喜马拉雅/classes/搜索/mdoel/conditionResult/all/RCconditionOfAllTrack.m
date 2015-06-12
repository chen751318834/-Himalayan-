//
//  RCconditionOfAllTrack.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCconditionOfAllTrack.h"
#import "RCconditionOfAllTrackDoc.h"
#import "MJExtension.h"
@implementation RCconditionOfAllTrack
+ (NSDictionary *)objectClassInArray{
    return @{@"docs":[RCconditionOfAllTrackDoc class]};
}
@end
