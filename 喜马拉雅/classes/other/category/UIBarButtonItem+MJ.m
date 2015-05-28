//
//  UIBarButtonItem+MJ.m
//  传智微博
//
//  Created by teacher on 14-6-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIBarButtonItem+MJ.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (MJ)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.imageView.contentMode = UIViewContentModeLeft;
//    btn.backgroundColor = [UIColor blackColor];
    btn.size =  CGSizeMake(24, 40);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+ (instancetype)itemWithTitle:(NSString *)title bgImage:(NSString *)bgImage highBgImage:(NSString *)highBgImage target:(id)target action:(SEL)action{

    UIButton *btn = [[UIButton alloc] init];
    btn.font = [UIFont systemFontOfSize:13];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highBgImage] forState:UIControlStateHighlighted];
    btn.contentMode = UIViewContentModeCenter;
    //    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    CGSize size = [btn.currentTitle boundingRectWithSize:CGSizeMake(100, 35) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    btn.size =  CGSizeMake(size.width+5, size.height+8);
//    btn.size = CGSizeMake(50, 28);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];

}
@end
