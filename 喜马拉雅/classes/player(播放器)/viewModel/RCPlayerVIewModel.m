//
//  RCPlayerVIewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerVIewModel.h"
#import "RCPlaylist.h"


@interface RCPlayerVIewModel ()
@property(nonatomic,strong) NSArray  *playerlists;
@property(nonatomic,assign) NSUInteger currentTrackIndex;


@end
@implementation RCPlayerVIewModel
-  (NSArray *)playerlists{
    if (!_playerlists) {
         self.playerlists = [NSMutableArray array];

    }
    return _playerlists;
}

@end
