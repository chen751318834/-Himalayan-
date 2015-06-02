//
//  RCPlayerVIewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerVIewModel.h"
#import "RCPlaylist.h"
#import "RCNetWorkingTool.h"
#import "MJExtension.h"
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
- ( void)fetchplayerInfoWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    NSLog(@"%@",[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/detail?device=android&trackId=%@",self.trackId]);

    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/detail?device=android&trackId=%@",self.trackId] params:nil success:^(id json) {
       RCPlayerInfo * playInfo = [RCPlayerInfo objectWithKeyValues:json];
        self.playerInfo = playInfo;
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
        NSLog(@"%@",error);
    }];

}
@end
