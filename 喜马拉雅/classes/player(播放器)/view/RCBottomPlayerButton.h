//
//  RCBottomPlayerButton.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCBottomPlayerButton : UIView
@property (weak, nonatomic) IBOutlet UIButton *button;
+ (instancetype)playerButton;
+ (instancetype)playingAudioButton;
- (void)moveToBottom;
- (void)moveToTop;

@property(nonatomic,copy) NSString  *imgSrc;

@end
