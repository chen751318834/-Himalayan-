//
//  RCPlayerViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/31.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerViewController.h"
#import "CSStickyHeaderFlowLayout.h"
#import "RCConst.h"
#import "RCPlayerHeaderView.h"
#import "RCPlayerCommentViewController.h"
#import "RCPlayerDeialViewController.h"
#import "RCPlayerAlbumViewController.h"
#import "RCContentViewCell.h"
#import "RCPlayerVIewModel.h"
@interface RCPlayerViewController ()
@property(nonatomic,weak) RCPlayerCommentViewController   *commentVC;
@property(nonatomic,weak) RCPlayerDeialViewController   *deailVC;
@property(nonatomic,weak) RCPlayerAlbumViewController   *albumVC;
@property(nonatomic,weak) UIViewController   *displayingController;
@property(nonatomic,assign) NSUInteger lastSelectedIndex;
@property(nonatomic,weak) RCPlayerHeaderView   *headerView;
@property(nonatomic,strong) RCPlayerVIewModel  *viewmodel;

@end

@implementation RCPlayerViewController
-  (RCPlayerVIewModel *)viewmodel{
    if (!_viewmodel) {
         self.viewmodel = [[RCPlayerVIewModel alloc]init];
        self.viewmodel.trackId = self.trackId;
    }
    return _viewmodel;
}
-  (RCPlayerCommentViewController *)commentVC{
    if (!_commentVC) {
        RCPlayerCommentViewController * commentVC = [[RCPlayerCommentViewController alloc]init];
        self.commentVC = commentVC;
        [self addChildViewController:commentVC];
    }
    return _commentVC;
}
-  (RCPlayerDeialViewController *)deailVC{
    if (!_deailVC) {
        RCPlayerDeialViewController * deailVC = [[RCPlayerDeialViewController alloc]init];
        self.deailVC = deailVC;
        [self addChildViewController:deailVC];

    }
    return _deailVC;
}
-  (RCPlayerAlbumViewController *)albumVC{
    if (!_albumVC) {
        RCPlayerAlbumViewController * albumVC = [[RCPlayerAlbumViewController alloc]init];
        self.albumVC = albumVC;
        [self addChildViewController:albumVC];

    }
    return _albumVC;
}
-(instancetype)init
{
    self = [super initWithControllers:self.commentVC  ,self.deailVC,self.albumVC, nil];
    if (self) {
        // your code
        self.headerHeight = [UIScreen mainScreen].bounds.size.height - 100;
        self.segmentMiniTopInset = 70;
    }

    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewmodel fetchplayerInfoWithSuccess:^{
        self.headerView.playerInfo = self.viewmodel.playerInfo;
    } failure:^{

    }];
   }
-(UIView<ARSegmentPageControllerHeaderProtocol> *)customHeaderView{
    RCPlayerHeaderView * headerView = [RCPlayerHeaderView headerView];
    self.headerView = headerView;
    return headerView;
}



-(void)backHome{
    [RCNotificationCenter postNotificationName:backHomeNotification object:nil];
}




@end
