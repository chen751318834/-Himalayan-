//
//  RCUserInfoHeaderView.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/11.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCSearchUserInfo.h"
@interface RCUserInfoHeaderView : UIView
@property(nonatomic,strong) RCSearchUserInfo  *userInfo;
+ (instancetype)headerView;
@end
