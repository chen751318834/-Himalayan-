//
//  RCRecordingInstructionsViewController.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/14.
//  Copyright © 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RCRecordingInstructionsViewController;

@protocol RCRecordingInstructionsViewControllerDelegate <NSObject>

@required
- (void)didScrollToEnd:(RCRecordingInstructionsViewController *)recordingInstructionsViewController;

@end
@interface RCRecordingInstructionsViewController : UIViewController
@property(nonatomic,weak) id<RCRecordingInstructionsViewControllerDelegate>   delegate;

@end
