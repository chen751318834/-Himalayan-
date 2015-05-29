//
//  RCAboutAlbumViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/28.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCAlbum.h"
@interface RCAboutAlbumViewCell : UITableViewCell
@property(nonatomic,strong) RCAlbum  *album;
+ (instancetype)cell;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end
