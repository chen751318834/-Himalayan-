//
//  RCSearchUserInfo.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/10.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSearchUserInfo.h"
#import "MJExtension.h"
@implementation RCSearchUserInfo
/**
 *  /@property(nonatomic,strong) NSNumber  *newAts;
 @property(nonatomic,strong) NSNumber  *newEvetCount;
 @property(nonatomic,strong) NSNumber  *newThirdRegisters;
 @property(nonatomic,strong) NSNumber  *newComments;
 @property(nonatomic,strong) NSNumber  *totalSpace;
 */
+ (NSDictionary *)replacedKeyFromPropertyName{

    return @{@"evetCount":@"newEvetCount",@"thirdRegisters":@"newThirdRegisters",@"comments":@"newComments",@"ats":@"newAts"};
}
@end

