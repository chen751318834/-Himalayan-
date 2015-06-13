//
//  RCAllConditionSectionheaderView.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCAllConditionSectionheaderView : UIView
+(instancetype)sectionHeaderView;
@property (weak, nonatomic) IBOutlet UIButton *changeDataButton;
@property (weak, nonatomic) IBOutlet UIButton *dataTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *resultCountButton;

@end
