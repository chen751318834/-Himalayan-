//
//  RCAlbumDownLoadSectionHeaderView.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/26.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCTitleButton.h"

@interface RCAlbumDownLoadSectionHeaderView : UIView
+(instancetype)sectionHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *currentRangeButton;
@end
