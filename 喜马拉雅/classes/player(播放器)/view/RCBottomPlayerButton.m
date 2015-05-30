//
//  RCBottomPlayerButton.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCBottomPlayerButton.h"

@implementation RCBottomPlayerButton
+ (instancetype)playerButton{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCBottomPlayerButton" owner:nil options:nil]lastObject];

}

@end
