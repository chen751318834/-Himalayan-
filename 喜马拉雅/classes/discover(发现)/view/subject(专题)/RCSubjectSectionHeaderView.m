//
//  RCSubjectSectionHeaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSubjectSectionHeaderView.h"

@implementation RCSubjectSectionHeaderView

+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"RCSubjectSectionHeaderView" owner:nil options:nil] lastObject];
}

@end
