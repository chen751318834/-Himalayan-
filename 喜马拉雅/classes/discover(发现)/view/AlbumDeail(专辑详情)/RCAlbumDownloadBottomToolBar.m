//
//  RCAlbumDownloadBottomToolBar.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/28.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumDownloadBottomToolBar.h"

@implementation RCAlbumDownloadBottomToolBar

+ (instancetype)toolbar{

    return [[[NSBundle mainBundle]loadNibNamed:@"RCAlbumDownloadBottomToolBar" owner:nil options:nil]lastObject];
}
@end
