//
//  RCSearchResultViewController.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCSearchViewModel.h"

@interface RCSearchResultViewController : UITableViewController
@property(nonatomic,strong) NSArray  *searchResult;
@property(nonatomic,assign) RCSearchViewModelDataType resultDataType;

@end
