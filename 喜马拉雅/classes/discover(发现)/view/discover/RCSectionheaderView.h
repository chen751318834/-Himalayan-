//
//  RCSectionheaderView.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCSectionheaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *titleButton;

+ (instancetype)headerView;
@end
