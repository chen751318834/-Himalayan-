//
//  RCAttentionData.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAttentionData.h"
#import "RCAttentionOneData.h"
#import "RCAttentionFrData.h"
#import "MJExtension.h"
@implementation RCAttentionData
+ (NSDictionary *)objectClassInArray{

    return @{@"datas":[RCAttentionOneData class],@"frDatas":[RCAttentionFrData class]};
}
@end
