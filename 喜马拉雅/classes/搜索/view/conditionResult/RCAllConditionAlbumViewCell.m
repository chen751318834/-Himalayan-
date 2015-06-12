//
//  RCAllConditionAlbumViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAllConditionAlbumViewCell.h"



@interface RCAllConditionAlbumViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *audioCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *updataTimelabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playCountLabelW;
@end
@implementation RCAllConditionAlbumViewCell

- (void)setDoc:(RCconditionOfAllAlbumDoc *)doc{
    _doc= doc;
}

@end
