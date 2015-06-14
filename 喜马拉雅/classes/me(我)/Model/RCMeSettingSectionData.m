//
//  RCMeSettingSectionData.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/14.
//  Copyright © 2015年 raychen. All rights reserved.
//

#import "RCMeSettingSectionData.h"
#import "MJExtension.h"
#import "RCMeSettingItem.h"
@implementation RCMeSettingSectionData
+ (NSDictionary *)objectClassInArray{

    return @{@"items":[RCMeSettingItem class]};
}
@end
