//
//  RCCicleDeailHeaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCCicleDeailHeaderView.h"

@implementation RCCicleDeailHeaderView
+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"RCCicleDeailHeaderView" owner:nil options:nil]lastObject];
}
- (void)setData:(RCZonePostHeadData *)data{

    _data = data;
}

@end
