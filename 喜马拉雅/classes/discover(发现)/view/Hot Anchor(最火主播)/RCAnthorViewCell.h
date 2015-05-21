//
//  RCAnthorViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCAnchorList.h"
@interface RCAnthorViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableview;
@property(nonatomic,strong) RCAnchorList  *anthorList;
@end
