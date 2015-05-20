//
//  RCTabBar.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/19.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCTabBar.h"
#import "RCConst.h"



@interface RCButton : UIButton

@end
@implementation RCButton

- (void)setHighlighted:(BOOL)highlighted{}

@end
@interface RCTabBar ()
@property(nonatomic,weak) RCButton * plusButton;
@end
@implementation RCTabBar


- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar_bg"];
        //创建加号按钮

        RCButton * plusButton = [RCButton buttonWithType:UIButtonTypeCustom];
        plusButton.backgroundColor = [UIColor clearColor];
        //        plusButton.backgroundColor = [UIColor redColor];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_np_default"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_np_normal"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_np_icon"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_np_normal"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_np_play"] forState:UIControlStateSelected];
        [self addSubview:plusButton];
        [plusButton addTarget:self action:@selector(plusBUttonClicked) forControlEvents:UIControlEventTouchUpInside];
        self.plusButton = plusButton;
        plusButton.selected = YES;
    }

    return self;


}
- (void)plusBUttonClicked{

    if ([self.tabBarDelegate respondsToSelector:@selector(tabBarDidPlusButton:)]) {
        [self.tabBarDelegate tabBarDidPlusButton:self];
    }

}
- (void)layoutSubviews{
    [super layoutSubviews];
    //布局加号按钮
    [self layoutPlusButton];

    //布局所有的子控件
    //        NSLog(@"%@", self.subviews );
    NSUInteger tabBarButtonIndex = 0;
    NSUInteger count = self.subviews.count;
    CGFloat childW = self.width/5;
    for (int i=0; i<count; i++) {
        UIView *childView = self.subviews[i];
        if ([childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //            NSLog(@"%@",childView);
            childView.width = childW;
            childView.x = childW*tabBarButtonIndex;
            tabBarButtonIndex ++;

            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    }

}
/**
 *  布局加号按钮
 */
- (void)layoutPlusButton{

    CGFloat plusBuutonW = 76;
    CGFloat plusBuutonH = 71.5;
    CGFloat plusBuutonX = (self.size.width - plusBuutonW) *0.5;
    CGFloat plusBuutonY = (self.size.height - plusBuutonH)*0.5;

    self.plusButton.width = plusBuutonW;
    self.plusButton.height = plusBuutonH;
    self.plusButton.x = plusBuutonX;
    self.plusButton.y = plusBuutonY;
}

@end
