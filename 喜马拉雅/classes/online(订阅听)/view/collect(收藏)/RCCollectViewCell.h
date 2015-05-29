//
//  RCCollectViewCell.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCAlbum.h"
@interface RCCollectViewCell : UITableViewCell
@property(nonatomic,strong) RCAlbum  *album;
+ (instancetype)cell ;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
