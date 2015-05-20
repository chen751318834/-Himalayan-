//
//  RCRecommendAlbums.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCRecommendAlbums.h"
#import "RCList.h"
#import "MJExtension.h"
@implementation RCRecommendAlbums
+ (NSDictionary *)objectClassInArray{

    return @{@"list":[RCList class]};
}
@end
