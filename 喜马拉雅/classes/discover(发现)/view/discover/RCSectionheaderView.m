//
//  RCSectionheaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSectionheaderView.h"



@implementation RCSectionheaderView

+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"RCSectionheaderView" owner:nil options:nil] lastObject];
}

@end
