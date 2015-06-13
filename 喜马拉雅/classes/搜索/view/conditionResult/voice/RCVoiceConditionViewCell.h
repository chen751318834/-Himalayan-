//
//  RCVoiceConditionViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/13.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCConditionResponseDoc.h"
@interface RCVoiceConditionViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property(nonatomic,strong) RCConditionResponseDoc  *doc;
@end
