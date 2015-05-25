//
//  RCAlbumViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCAlbum.h"
@interface RCAlbumViewCell : UITableViewCell
+ (instancetype)cell;
@property(nonatomic,strong) RCAlbum  *album;
@end
