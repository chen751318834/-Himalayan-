//
//  RCAlbumDownLoadSectionHeaderView.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/26.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumDownLoadSectionHeaderView.h"
@interface RCAlbumDownLoadSectionHeaderView ()


@end
@implementation RCAlbumDownLoadSectionHeaderView
+ (instancetype)sectionHeaderView{
    return [[[NSBundle mainBundle]loadNibNamed:@"RCAlbumDownLoadSectionHeaderView" owner:nil options:nil]lastObject];
}
@end
