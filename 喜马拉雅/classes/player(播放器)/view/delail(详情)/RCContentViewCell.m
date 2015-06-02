//
//  RCContentViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/31.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCContentViewCell.h"
#import "RCPlayerCommentViewController.h"
#import "RCPlayerDeialViewController.h"
#import "RCPlayerAlbumViewController.h"
#import "RCConst.h"
@interface RCContentViewCell ()
@property(nonatomic,weak) RCPlayerCommentViewController   *commentVC;

@property(nonatomic,weak) RCPlayerDeialViewController   *deailVC;
@property(nonatomic,weak) RCPlayerAlbumViewController   *albumVC;
@end

@implementation RCContentViewCell
-  (RCPlayerCommentViewController *)commentVC{
    if (!_commentVC) {
        RCPlayerCommentViewController * commentVC = [[RCPlayerCommentViewController alloc]init];
        commentVC.view.frame = CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height - 80);

        self.commentVC = commentVC;
    }
    return _commentVC;
}
-  (RCPlayerDeialViewController *)deailVC{
    if (!_deailVC) {
        RCPlayerDeialViewController * deailVC = [[RCPlayerDeialViewController alloc]init];
        deailVC.view.frame = CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height- 80);

        self.deailVC = deailVC;


    }
    return _deailVC;
}
-  (RCPlayerAlbumViewController *)albumVC{
    if (!_albumVC) {
        RCPlayerAlbumViewController * albumVC = [[RCPlayerAlbumViewController alloc]init];
        albumVC.view.frame = CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height-80);
        self.albumVC = albumVC;

    }
    return _albumVC;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
///////////
- (instancetype)init
{
    self = [super init];
    if (self) {
        [RCNotificationCenter addObserver:self selector:@selector(changeController:) name:changePlayerChildControllerNotification object:nil];

    }
    return self;
}
/**
 *  <#Description#>
 *
 *  @param note <#note description#>
 */
- (void)changeController:(NSNotification *)note{
    RCLog(@"%ld",[note.userInfo[changePlayerChildControllerOfSelectedindex] integerValue]);
    switch ([note.userInfo[changePlayerChildControllerOfSelectedindex] integerValue]) {
        case 0:
            [self.deailVC.view removeFromSuperview];
            [self.albumVC.view removeFromSuperview];
            [self addSubview:self.commentVC.view ];
            break;
        case 1:
            [self.commentVC.view removeFromSuperview];
            [self.albumVC.view removeFromSuperview];
            [self addSubview:self.deailVC.view ];
            break;
        case 2:
            [self.deailVC.view removeFromSuperview];
            [self.commentVC.view removeFromSuperview];
            [self addSubview:self.albumVC.view ];

            break;
    }
}
////
- (void)dealloc{

    [RCNotificationCenter removeObserver:self];
}
@end
