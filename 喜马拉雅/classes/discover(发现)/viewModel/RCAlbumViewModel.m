//
//  RCAlbumViewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumViewModel.h"
#import "RCAlbum.h"
#import "RCAlbumTrack.h"
#import "RCTrack.h"
#import <UIKit/UIKit.h>

@interface RCAlbumViewModel ()
@property(nonatomic,strong) NSMutableArray  *trarkLists;
@end
@implementation RCAlbumViewModel
-  (NSMutableArray *)trarkLists{
    if (!_trarkLists) {
        self.trarkLists = [NSMutableArray array];

    }
    return _trarkLists;
}
- ( void)fetchNewHotAlbumDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{

    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_album_list?category_name=all&condition=hot&device=android&page=1&per_page=20&status=0&tag_name="] params:nil success:^(id json) {
        [self.models removeAllObjects];
        NSArray * newAudios = [RCAlbum objectArrayWithKeyValuesArray:json[@"list"]];
        [self.models addObjectsFromArray:newAudios];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];

}
- ( void)fetchMoreHotAlbumDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{


    self.currrentPage ++;
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_album_list?category_name=all&condition=hot&device=android&page=%ld&per_page=20&status=0&tag_name=",self.currrentPage] params:nil success:^(id json) {
        NSArray * newAudios = [RCAlbum objectArrayWithKeyValuesArray:json[@"list"]];
        NSNumber *  maxPageID = (NSNumber *)json[@"maxPageId"];
        if (self.currrentPage  > [maxPageID integerValue]) {
            if (completion) {
                completion();
            }
            return ;
        }
        [self.models addObjectsFromArray:newAudios];
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];

}

- ( void)fetchNewReccentAlbumDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{


    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_album_list?category_name=all&condition=recent&device=android&page=1&per_page=20&status=0&tag_name="] params:nil success:^(id json) {
        [self.models removeAllObjects];
        NSArray * newAudios = [RCAlbum objectArrayWithKeyValuesArray:json[@"list"]];
        
        [self.models addObjectsFromArray:newAudios];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}
- ( void)fetchMoreReccentAlbumDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{

    self.currrentPage ++;
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_album_list?category_name=all&condition=recent&device=android&page=%ld&per_page=20&status=0&tag_name=",self.currrentPage] params:nil success:^(id json) {
        NSArray * newAudios = [RCAlbum objectArrayWithKeyValuesArray:json[@"list"]];
        NSNumber *  maxPageID = (NSNumber *)json[@"maxPageId"];
        if (self.currrentPage  > [maxPageID integerValue]) {
            if (completion) {
                completion();
            }
            return ;
        }
        [self.models addObjectsFromArray:newAudios];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}

- ( void)fetchNewClassicsDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{

    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_album_list?category_name=all&condition=classic&device=android&page=1&per_page=20&status=0&tag_name="] params:nil success:^(id json) {
        [self.models removeAllObjects];
        NSArray * newAudios = [RCAlbum objectArrayWithKeyValuesArray:json[@"list"]];
        [self.models addObjectsFromArray:newAudios];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}
- ( void)fetchMoreClassicsDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{

    self.currrentPage ++;
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_album_list?category_name=all&condition=classic&device=android&page=%ld&per_page=20&status=0&tag_name=",self.currrentPage] params:nil success:^(id json) {
        NSArray * newAudios = [RCAlbum objectArrayWithKeyValuesArray:json[@"list"]];
        NSNumber *  maxPageID = (NSNumber *)json[@"maxPageId"];
        if (self.currrentPage  > [maxPageID integerValue]) {
            if (completion) {
                completion();
            }
            return ;
        }
        [self.models addObjectsFromArray:newAudios];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}

- ( void)fetchNewAlbumDeailDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{

    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%@/true/1/15",self.ID] params:nil success:^(id json) {
        [self.trarkLists removeAllObjects];
        RCAlbumTrack  * albumTrack  = [RCAlbumTrack objectWithKeyValues:json];
        [self.trarkLists addObjectsFromArray:albumTrack.tracks.list];
        self.totalCount = albumTrack.tracks.totalCount;
        self.album = albumTrack.album;
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];

}
- ( void)fetchMoreAlbumDeailDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    self.currrentPage ++;
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%@/true/%ld/15",self.ID,self.currrentPage] params:nil success:^(id json) {
        RCAlbumTrack  * albumTrack  = [RCAlbumTrack objectWithKeyValues:json];
        NSNumber *  maxPageID = (NSNumber *)json[@"tracks"][@"maxPageId"];
        if (self.currrentPage  > [maxPageID integerValue]) {
            if (completion) {
                completion();
            }
            return ;
        }
        [self.trarkLists addObjectsFromArray:albumTrack.tracks.list];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];


}
- (NSInteger)numberOfRowOfAlbumDeailDataInSection: (NSInteger)section{
    return self.trarkLists.count;

}
- (RCTrackList *)trackListAtIndexPath: (NSIndexPath *)indexPath{

    return self.trarkLists[indexPath.item];
}
@end
