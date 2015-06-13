//
//  RCAllConditionSectionheaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAllConditionSectionheaderView.h"

@implementation RCAllConditionSectionheaderView
+ (instancetype)sectionHeaderView{

    return [[[NSBundle mainBundle]loadNibNamed:@"RCAllConditionSectionheaderView" owner:nil options:nil]lastObject];
}

@end
