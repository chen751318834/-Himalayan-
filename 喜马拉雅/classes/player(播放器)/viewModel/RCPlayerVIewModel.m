//
//  RCPlayerVIewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerVIewModel.h"
#import "RCPlaylist.h"
#import "RCPlayerCommnetList.h"
#import "RCNetWorkingTool.h"

#import "MJExtension.h"
@interface RCPlayerVIewModel ()
@property(nonatomic,assign) NSUInteger currentTrackIndex;


@end
@implementation RCPlayerVIewModel
-  (NSMutableArray *)comments{
    if (!_comments) {
        self.comments = [NSMutableArray array];

    }
    return _comments;
}
-  (NSMutableArray *)deails{
    if (!_deails) {
        self.deails = [NSMutableArray array];

    }
    return _deails;
}
-  (NSMutableArray *)albums{
    if (!_albums) {
        self.albums = [NSMutableArray array];

    }
    return _albums;
}
-  (NSMutableArray *)playerlists{
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
- ( void)fetchNewPlayerCommnetWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    NSMutableDictionary *  params = [NSMutableDictionary dictionary];
    //device=android&pageSize=15&pageId=1&trackId=7134464
    params[@"device"] = @"android";
    params[@"pageSize"] = @15;
    params[@"pageId"] = @(self.currrentPage);
    params[@"trackId"] =  self.trackId;
    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/mobile/track/comment" params:params success:^(id json) {
        RCPlayerCommnet * comment = [RCPlayerCommnet objectWithKeyValues:json];
        self.comment = comment;
        NSArray * newAudios = comment.list;
        [self.comments addObjectsFromArray:newAudios];
        if (success) {
            success();
        }
          } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}
- ( void)fetchMorePlayerCommnetWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    self.currrentPage ++;
    NSMutableDictionary *  params = [NSMutableDictionary dictionary];
    params[@"device"] = @"android";
    params[@"pageSize"] = @15;
    params[@"pageId"] = @(self.currrentPage);
    params[@"trackId"] =  self.trackId;
    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/mobile/track/comment" params:params success:^(id json) {
        RCPlayerCommnet * comment = [RCPlayerCommnet objectWithKeyValues:json];
        NSArray * newAudios = comment.list;
        [self.comments addObjectsFromArray:newAudios];
        if (success) {
            success();
        }
        NSNumber *  maxPageID = (NSNumber *)json[@"maxPageId"];
        if (self.currrentPage  > [maxPageID integerValue]) {
            if (completion) {
                completion();
            }
            return ;
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];

}

- ( void)fetchPlayerTrackDeailWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    NSLog(@"%@",[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/detail?device=android&trackId=%@",self.trackId]);
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/track/detail?device=android&trackId=%@",self.trackId] params:nil success:^(id json) {
        RCPlayerTrackDeail * deail = [RCPlayerTrackDeail objectWithKeyValues:json];
        [self.deails addObject:deail];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}
- ( void)fetchPlayerAlbumWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://ar.ximalaya.com/rec-association/recommend/album?device=android&trackId=%@",self.trackId] params:nil success:^(id json) {
        NSArray * newAlbums = [RCPlayerAlbum objectArrayWithKeyValuesArray:json[@"albums"]];
        [self.albums addObjectsFromArray:newAlbums];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];

}
- ( void)fetchPlayListWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{

    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/playlist/album?device=android&albumId=%@&trackId=%@",self.playerInfo.albumId,self.trackId] params:nil success:^(id json) {
        NSArray * list = [RCPlaylist objectArrayWithKeyValuesArray:json[@"data"]];
        [self.playerlists removeAllObjects];
        [self.playerlists addObjectsFromArray:list];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];


}
@end
