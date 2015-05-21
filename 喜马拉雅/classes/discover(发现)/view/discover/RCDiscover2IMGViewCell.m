//
//  RCDiscover2IMGViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCDiscover2IMGViewCell.h"
#import "RCHotAnthorViewController.h"
#import "RCTabBarViewController.h"
#import "RCNavigationController.h"
@interface RCDiscover2IMGViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon1View;
@property (weak, nonatomic) IBOutlet UIImageView *icon2View;
@end
@implementation RCDiscover2IMGViewCell

- (void)awakeFromNib{
//finditem_hotpeople
//finditem_hotsound
    self.icon1View.userInteractionEnabled = YES;
    self.icon2View.userInteractionEnabled = YES;
    [self.icon1View setImage:[UIImage imageNamed:@"finditem_hotpeople"]];
    [self.icon2View setImage:[UIImage imageNamed:@"finditem_hotsound"]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self adddGer:self.icon1View action:@selector(icon1ViewDidClicked)];
    [self adddGer:self.icon2View action:@selector(icon2ViewDidClicked)];

}
- (void)adddGer:(UIImageView *)imageView action:(SEL)action{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    [imageView addGestureRecognizer:tap];
}
- (void)icon1ViewDidClicked{

    RCTabBarViewController * tabBarVC =(RCTabBarViewController *)   [UIApplication sharedApplication].keyWindow.rootViewController;
    RCNavigationController * navVC = ( RCNavigationController *)tabBarVC.selectedViewController;
    [navVC pushViewController:[[RCHotAnthorViewController alloc]init] animated:YES];
    NSLog(@"icon1ViewDidClicked");

}
- (void)icon2ViewDidClicked{

    NSLog(@"icon2ViewDidClicked");
}
@end
