//
//  RCBaseViewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCBaseViewModel.h"
#import "RCNetWorkingTool.h"

@interface RCBaseViewModel ()
@end
@implementation RCBaseViewModel
-  (NSMutableArray *)models{
    if (!_models) {
        self.models = [NSMutableArray array];

    }
    return _models;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currrentPage = 1;
    }
    return self;
}
@end
