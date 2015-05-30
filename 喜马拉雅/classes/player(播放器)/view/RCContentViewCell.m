//
//  RCContentViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCContentViewCell.h"
#import "RCConst.h"
#import "RCPlayerAlbumViewController.h"
#import "RCPlayerDeialViewController.h"
#import "RCPlayerCommentViewController.h"
@interface RCContentViewCell() <UIScrollViewDelegate>
@property(nonatomic,strong) RCPlayerAlbumViewController   *albumVC;
@property(nonatomic,strong) RCPlayerCommentViewController   *commentVC;
@property(nonatomic,strong) RCPlayerDeialViewController   *deailVC;
@end
@implementation RCContentViewCell

-  (RCPlayerCommentViewController *)commentVC{
    if (!_commentVC) {
        RCPlayerCommentViewController * commentVC = [[RCPlayerCommentViewController alloc]init];
        self.commentVC = commentVC;

    }
    return _commentVC;
}
-  (RCPlayerDeialViewController *)deailVC{
    if (!_deailVC) {
        RCPlayerDeialViewController * deailVC = [[RCPlayerDeialViewController alloc]init];
        self.deailVC = deailVC;
    }
    return _deailVC;
}
-  (RCPlayerAlbumViewController *)albumVC{
    if (!_albumVC) {
        RCPlayerAlbumViewController * albumVC = [[RCPlayerAlbumViewController alloc]init];
        self.albumVC = albumVC;
    }
    return _albumVC;
}
+ (instancetype)cell{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCContentViewCell" owner:nil options:nil]lastObject];
}
- (void)awakeFromNib {
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width*3, 0);
    [RCNotificationCenter addObserver:self selector:@selector(changeView:) name:selectedSegmentControlIndexNotification object:nil];
    [self.scrollView addSubview:self.commentVC.view];
    [self.scrollView addSubview:self.deailVC.view];
    [self.scrollView addSubview:self.albumVC.view];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.commentVC.view.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.deailVC.view.frame = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
    self.albumVC.view.frame = CGRectMake(self.bounds.size.width*2, 0, self.bounds.size.width, self.bounds.size.height);
//
}
- (void)changeView:(NSNotification *)note{
    [UIView animateWithDuration:0.5 animations:^{
    [self.scrollView setContentOffset:CGPointMake([note.userInfo[selectedSegmentControlIndexNotificationName] intValue]* self.bounds.size.width, 0) animated:YES];
    }];
}
- (void)dealloc{
    [RCNotificationCenter removeObserver:self];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width*3, 0);

    if ([self.delegate respondsToSelector:@selector(didScroll:offfset:)]) {
        [self.delegate didScroll:self offfset:scrollView.contentOffset];
    }

}
@end
