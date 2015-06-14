//
//  RCmoreHotAnthorViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/14.
//  Copyright © 2015年 raychen. All rights reserved.
//

#import "RCmoreHotAnthorViewController.h"
#import "RCTitleButton.h"
#import "UIView+JHChainableAnimations.h"
#import "RCConst.h"
@interface RCmoreHotAnthorViewController ()
@property(nonatomic,weak) UICollectionView   *collectionView;

@end
@implementation RCmoreHotAnthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self setUpCollectionView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUpCollectionView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -200, self.view.bounds.size.width, 200) collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor redColor];
    self.collectionView = collectionView;


}
- (void)setUpNav{
    RCTitleButton * titlebutton = [[RCTitleButton alloc]init];
    [titlebutton setTitle:@"sssss" forState:UIControlStateNormal];
    [titlebutton addTarget:self action:@selector(titleButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [titlebutton setImage:[UIImage imageNamed:@"navidrop_arrow_down_n"] forState:UIControlStateNormal];
    CGFloat width = [titlebutton.currentTitle boundingRectWithSize:CGSizeMake(self.view.bounds.size.width, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.width +10;
    titlebutton.frame = CGRectMake(0, 0, width, 35);
    self.navigationItem.titleView = titlebutton;

}

#pragma mark - 事件处理
- (void)titleButtonDidClicked:(UIButton *)button{
    if (button.isSelected) {
        self.collectionView.moveY(-264).easeInOutBounce.animate(0.25);

    }else{
        self.collectionView.moveY(264).easeOutBounce.animate(0.25);

    }
    button.imageView.rotate(180).animate(0.25);
    button.userInteractionEnabled = NO;
    __weak typeof(button) weekButton = button;
    button.imageView.animationCompletion = JHAnimationCompletion(){
        weekButton.userInteractionEnabled = YES;
    };
    button.selected = !button.isSelected;
}
@end
