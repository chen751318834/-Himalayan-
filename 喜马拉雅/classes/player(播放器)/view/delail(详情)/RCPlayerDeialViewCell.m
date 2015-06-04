//
//  RCPlayerDeialViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/3.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerDeialViewCell.h"
#import "RegexKitLite.h"
#import "UIView+Extension.h"
#import "RCTabBarViewController.h"
#import "RCPlayerView.h"
#import "RCNavigationController.h"
#import "RCOneAlbumViewController.h"
#import "UIView+AutoLayout.h"
#import "NSString+MJExtension.h"
#import "TLTagsControl.h"
#import "NSString+MJExtension.h"
static const CGFloat margin = 10;
@interface RCPlayerDeialViewCell () <TLTagsControlDelegate>
@property (weak, nonatomic) IBOutlet UIView *tagsView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property(nonatomic,strong) NSMutableArray  *buttons;
@property(nonatomic,weak) TLTagsControl   *tagsControl;
@property (weak, nonatomic) IBOutlet TLTagsControl *tagsScrollView;
@property(nonatomic,strong) NSMutableArray  *tags;
@end
@implementation RCPlayerDeialViewCell


-  (NSMutableArray *)buttons{
    if (!_buttons) {
        self.buttons = [NSMutableArray array];

    }
    return _buttons;
}
- (void)setDeail:(RCPlayerTrackDeail *)deail{
    _deail = deail;
    self.contentLabel.text = [NSString flattenHTML:deail.intro trimWhiteSpace:YES];
        self.songLabel.text = [NSString flattenHTML:deail.richIntro trimWhiteSpace:YES];

    NSMutableArray * tags = [NSMutableArray array];
    [deail.tags enumerateStringsSeparatedByRegex:@"," usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        [tags addObject:*capturedStrings];

    }];


    self.tagsScrollView.tags = [tags mutableCopy];
    [self.tagsScrollView reloadTagSubviews];

}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.tagsScrollView.mode = TLTagsControlModeList;
    [self.tagsScrollView setTapDelegate:self];
    self.tagsScrollView.tagsBackgroundColor = [UIColor grayColor];
    self.tagsScrollView.tagsTextColor = [UIColor whiteColor];
}
- (void)tagsControl:(TLTagsControl *)tagsControl tappedAtIndex:(NSInteger)index{
    NSString * tag = tagsControl.tags[index];
    RCOneAlbumViewController * albumVc = [[RCOneAlbumViewController alloc]init];
    albumVc.tag = tag;
    [RCPlayerView pushViewController:albumVc];

}
@end
