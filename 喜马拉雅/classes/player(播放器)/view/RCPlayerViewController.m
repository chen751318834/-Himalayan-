//
//  RCPlayerViewController.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/31.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerViewController.h"
#import "CSStickyHeaderFlowLayout.h"
#import <MediaPlayer/MediaPlayer.h>

#import "RCConst.h"
#import "UIImageView+WebCache.h"
#import "RCPlayerHeaderView.h"
#import "RCPlayerCommentViewController.h"
#import "RCPlayerDeialViewController.h"
#import "RCPlayerAlbumViewController.h"
#import "UIImage+RC.h"
#import "RCContentViewCell.h"
#import "RCBottomPlayerButton.h"
#import "RCConst.h"
#import "RCPlayerVIewModel.h"
#import "UIImage+ImageEffects.h"
#import "UIImageView+EXtension.h"
void *CusomHeaderInsetObserver = &CusomHeaderInsetObserver;

@interface RCPlayerViewController ()
@property(nonatomic,weak) RCPlayerCommentViewController *commentVC;
@property(nonatomic,weak) RCPlayerDeialViewController   *deailVC;
@property(nonatomic,weak) RCPlayerAlbumViewController   *albumVC;
@property(nonatomic,weak) UIViewController   *displayingController;
@property(nonatomic,assign) NSUInteger lastSelectedIndex;
@property(nonatomic,weak) RCPlayerHeaderView   *headerView;
@property(nonatomic,weak) RCBottomPlayerButton * button;

@property(nonatomic,strong) RCPlayerVIewModel  *viewmodel;

@end
@implementation RCPlayerViewController
-  (RCPlayerVIewModel *)viewmodel{
    if (!_viewmodel) {
         self.viewmodel = [[RCPlayerVIewModel alloc]init];
//        self.viewmodel.trackId = self.trackId;
    }
    return _viewmodel;
}

-(instancetype)init
{
    RCPlayerCommentViewController * commentVC = [[RCPlayerCommentViewController alloc]init];
    self.commentVC = commentVC;
    RCPlayerDeialViewController * deailVC = [[RCPlayerDeialViewController alloc]init];
    self.deailVC = deailVC;
    RCPlayerAlbumViewController * albumVC = [[RCPlayerAlbumViewController alloc]init];
    self.albumVC = albumVC;
    self = [super initWithControllers:commentVC,deailVC,albumVC, nil];
    if (self) {
        self.headerHeight = [UIScreen mainScreen].bounds.size.height- self.segmentHeight;
        self.segmentMiniTopInset = 66;
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];

}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];


    [self addObserver:self forKeyPath:@"segmentToInset" options:NSKeyValueObservingOptionNew context:CusomHeaderInsetObserver];
    [RCNotificationCenter addObserver:self selector:@selector(fecthData:) name:sendNetWorkingNotification object:nil];
    if (self.trackId) {
    [RCNotificationCenter postNotificationName:sendTrackIdNotification object:nil userInfo:@{trackIdNotificationName:self.trackId}];
    }
    [RCNotificationCenter addObserver:self selector:@selector(applicationDidEnterBackgroundSetSongInformation:) name:RCPlayerViewSetSongInformationNotification object:nil];

   }
- (void)fecthData:(NSNotification *)note{
    NSMutableArray * childViews = [[UIApplication sharedApplication].keyWindow valueForKeyPath:@"subviews"];
    RCBottomPlayerButton * button = (RCBottomPlayerButton *)[childViews objectAtIndex:1];
    self.viewmodel.trackId = note.userInfo[netWorkingParamNotification];
    [self.viewmodel fetchplayerInfoWithSuccess:^{
        self.headerView.playerInfo = self.viewmodel.playerInfo;
        self.commentVC.trackId = self.viewmodel.playerInfo.trackId;
        self.deailVC.trackId = self.viewmodel.playerInfo.trackId;
        self.albumVC.playerInfo = self.viewmodel.playerInfo;
        button.imgSrc = self.viewmodel.playerInfo.coverLarge;

    } failure:^{
        
    }];
}
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"segmentToInset"];

    [RCNotificationCenter removeObserver:self];
}
-(UIView<ARSegmentPageControllerHeaderProtocol> *)customHeaderView{
    RCPlayerHeaderView * headerView = [RCPlayerHeaderView headerView];
    self.headerView = headerView;
    return headerView;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    if (context == CusomHeaderInsetObserver) {
        CGFloat inset = [change[NSKeyValueChangeNewKey] floatValue];
        if (inset <= self.segmentMiniTopInset + 30) {
            self.headerView.topImageView.hidden = NO;

        }else{
            self.headerView.topImageView.hidden = YES;

        }

    }
   }
-(void)applicationDidEnterBackgroundSetSongInformation:(NSNotification *)notification
{

    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:self.viewmodel.playerInfo.title forKey:MPMediaItemPropertyTitle];
        [dict setObject:self.viewmodel.playerInfo.albumTitle  forKey:MPMediaItemPropertyArtist];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:nil];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
