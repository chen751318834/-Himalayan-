//
//  RCSearchViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKTagView.h"
@interface RCSearchViewCell : UITableViewCell
@property(nonatomic,weak) IBOutlet SKTagView   *tagView;
@property(nonatomic,assign,getter=isSearchHistory) BOOL searchHistory;
- (void)clearSearchHistoryWithTarget:(id)target action:(SEL)action;
@end
