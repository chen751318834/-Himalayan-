//
//  RCBaseViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "RCNetWorkingTool.h"
@interface RCBaseViewModel : NSObject
@property(nonatomic,strong) NSMutableArray  *models;
@property(nonatomic,assign) NSUInteger currrentPage;

@end
