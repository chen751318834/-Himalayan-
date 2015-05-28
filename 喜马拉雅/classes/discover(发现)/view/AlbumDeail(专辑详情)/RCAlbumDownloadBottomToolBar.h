//
//  RCAlbumDownloadBottomToolBar.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/28.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCAlbumDownloadBottomToolBar : UIView
+ (instancetype)toolbar;
@property (weak, nonatomic) IBOutlet UIButton *nowDownloaduButton;
@property (weak, nonatomic) IBOutlet UIButton *seleectedAllButton;

@end
