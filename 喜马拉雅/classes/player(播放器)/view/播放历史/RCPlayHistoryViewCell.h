//
//  RCPlayHistoryViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/6.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCPlayerInfo.h"
@interface RCPlayHistoryViewCell : UITableViewCell
@property(nonatomic,strong) RCPlayerInfo  *info;
+ (instancetype)cell;
@end
