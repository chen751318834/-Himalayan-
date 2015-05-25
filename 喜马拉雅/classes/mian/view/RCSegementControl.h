//
//  RCSegementControl.h
//  QQZone
//
//  Created by Raychen on 14/12/28.
//  Copyright (c) 2014年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCSegementControl;

@protocol RCSegementControlDelegate <NSObject>

@optional
- (void)segementControl:(RCSegementControl *)segement from:(int)from to:(int)to;

@end
@interface RCSegementControl : UIView
/**
 *  存放标题的数组
 */
@property(strong,nonatomic) NSArray* items;
/**
 *  索引
 */
@property (nonatomic, assign)int selectedSegmentIndex;
@property(nonatomic,weak) id  delegate;
@end
