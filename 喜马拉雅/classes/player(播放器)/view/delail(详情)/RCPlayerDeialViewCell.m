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
static const CGFloat margin = 10;
@interface RCPlayerDeialViewCell ()
@property (weak, nonatomic) IBOutlet UIView *tagsView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property(nonatomic,strong) NSMutableArray  *buttons;

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
    self.contentLabel.text = @"sdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasd";
        self.songLabel.text = @"sdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasdsdasdasdasdasdasdasd";

    NSMutableArray * tags = [NSMutableArray array];
    [deail.tags enumerateStringsSeparatedByRegex:@"," usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        [tags addObject:*capturedStrings];

    }];
    [self.buttons removeAllObjects];
    for (int i = 0; i<tags.count; i++) {
        NSString * tag  = tags[i];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.tagsView addSubview:button];
        [button setBackgroundImage:[UIImage imageNamed:@"sound_tags"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"sound_tags_s"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button  setFont:[UIFont systemFontOfSize:11]];
        [button setTitle:tag forState:UIControlStateNormal];
        button.contentMode = UIViewContentModeCenter;
        [self.buttons addObject:button];

    }


}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat H = 20;
    CGFloat W  = 80;
    NSUInteger photosCount = self.buttons.count;
    int maxCol = 4;
    for (int i = 0; i<photosCount; i++) {
        UIButton * button = self.buttons[i];
//        int col = i % maxCol;
        button.width = W;
        button.height = H;
        button.x = (i % maxCol) * (W+ margin);
        int row = i / maxCol;
        button.y = row * (H + margin)+margin;

    }


}
@end
