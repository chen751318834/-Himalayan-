//
//  RCCategoryListViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/20.
//  Copyright (c) 2015年 Raychen. All rights reserved.
//

#import "RCCategoryListViewCell.h"

#import "UIImageView+WebCache.h"
@interface RCCategoryListViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconVIew;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation RCCategoryListViewCell
- (void)setList:(RCCategoryList *)list{

    _list = list;
    [self.iconVIew sd_setImageWithURL:[NSURL URLWithString:list.cover_path] placeholderImage:[UIImage imageNamed:@"find_usercover"]];
    self.titleLabel.text = list.tname;
}


@end
