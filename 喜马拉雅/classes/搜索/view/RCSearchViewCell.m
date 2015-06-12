//
//  RCSearchViewCell.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSearchViewCell.h"


@interface RCSearchViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
@implementation RCSearchViewCell
- (void)setSearchHistory:(BOOL)searchHistory{
    _searchHistory = searchHistory;
    if (searchHistory) {
  self.titleLabel.text = @"历史搜索";
        self.button.hidden = NO;
    }else{
        self.titleLabel.text = @"推荐搜索";
        self.button.hidden = YES;

    }
}
- (void)clearSearchHistoryWithTarget:(id)target action:(SEL)action{

    [self.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
 }
@end
