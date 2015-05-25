//
//  RCAlbumHeaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumHeaderView.h"
#import "CSStickyHeaderFlowLayoutAttributes.h"


@interface RCAlbumHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *tilteLabel;

@end
@implementation RCAlbumHeaderView
+ (instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:@"RCAlbumHeaderView" owner:nil options:nil]lastObject];
}


- (void)applyLayoutAttributes:(CSStickyHeaderFlowLayoutAttributes *)layoutAttributes {

    [UIView beginAnimations:@"" context:nil];

    if (layoutAttributes.progressiveness <= 0.58) {
        self.tilteLabel.alpha = 1;
    } else {
        self.tilteLabel.alpha = 0;
    }

      [UIView commitAnimations];
}
@end
