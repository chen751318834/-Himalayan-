//
//  RCConditionAlbumResponse.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCConditionResponse.h"
#import "MJExtension.h"
#import "RCConditionResponseDoc.h"
@implementation RCConditionResponse
+ (NSDictionary *)objectClassInArray{
    return @{@"docs":[RCConditionResponseDoc class]};
}
@end
