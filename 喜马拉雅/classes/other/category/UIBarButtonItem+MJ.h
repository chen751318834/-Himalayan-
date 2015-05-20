//
//  UIBarButtonItem+MJ.h
//  传智微博
//
//  Created by teacher on 14-6-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MJ)
/**
 *  通过图片创建item
 *
 *  @param image     图片
 *  @param highImage 高亮图片
 *  @param action    点击后调用的方法
 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;


+ (instancetype)itemWithTitle:(NSString *)title bgImage:(NSString *)bgImage highBgImage:(NSString *)highBgImage target:(id)target action:(SEL)action;
@end
