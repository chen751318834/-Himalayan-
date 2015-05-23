//
//  RCCicleDeailHeaderView.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/23.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCZonePostHeadData.h"
@interface RCCicleDeailHeaderView : UIView
+ (instancetype)headerView;
@property(nonatomic,strong) RCZonePostHeadData  *data;
@end
