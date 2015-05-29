//
//  RCAttentionViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCAttentionFrData.h"
@interface RCAttentionViewCell : UITableViewCell
+ (instancetype)cell;
@property(nonatomic,strong) RCAttentionFrData  *data;
@end
