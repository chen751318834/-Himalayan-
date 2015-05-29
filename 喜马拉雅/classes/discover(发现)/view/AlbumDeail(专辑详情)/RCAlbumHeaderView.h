//
//  RCAlbumHeaderView.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCAlbum.h"
@interface RCAlbumHeaderView : UICollectionReusableView
+ (instancetype)headerView;
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) RCAlbum  *album;
@property(nonatomic,strong) NSArray  *tracklist;
@property(nonatomic,strong) NSNumber  *albumId;
@end
