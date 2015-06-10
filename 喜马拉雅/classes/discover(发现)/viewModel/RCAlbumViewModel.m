//
//  RCAlbumViewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAlbumViewModel.h"
#import "RCAlbumTrack.h"
#import "RCTrack.h"
#import <UIKit/UIKit.h>

@interface RCAlbumViewModel ()
@property(nonatomic,strong) NSMutableArray  *aboutAlbumlists;
@end
@implementation RCAlbumViewModel
-  (NSMutableArray *)aboutAlbumlists{
    if (!_aboutAlbumlists) {
        self.aboutAlbumlists = [NSMutableArray array];

    }
    return _aboutAlbumlists;
}
-  (NSMutableArray *)trarkLists{
    if (!_trarkLists) {
        self.trarkLists = [NSMutableArray array];

    }
    return _trarkLists;
}
-  (NSMutableArray *)downloadLists{
    if (!_downloadLists) {
        self.downloadLists = [NSMutableArray array];

    }
    return _downloadLists;
}
- ( void)fetchNewHotAlbumDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"condition"] = @"hot";
    params[@"device"] = @"android";
    params[@"page"] = @1;
    params[@"per_page"] = @20;
    params[@"status"] = @0;
    if (self.tag_name) {
        params[@"category_name"] = self.category_name;
        params[@"tag_name"] = self.tag_name;
    }else{
        params[@"category_name"] = @"all";
        params[@"tag_name"] = @"";

 }
    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/m/explore_album_list" params:params success:^(id json) {
        [self.models removeAllObjects];
        NSArray * newAudios = [RCAlbum objectArrayWithKeyValuesArray:json[@"list"]];
        [self.models addObjectsFromArray:newAudios];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
            NSLog(@"%@",error);
        }
    }];

}
- ( void)fetchMoreHotAlbumDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    self.currrentPage ++;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"condition"] = @"hot";
    params[@"device"] = @"android";
    params[@"page"] = @(self.currrentPage);
    params[@"per_page"] = @20;
    params[@"status"] = @0;
    if (self.tag_name) {
        params[@"category_name"] = self.category_name;
        params[@"tag_name"] = self.tag_name;
    }else{
        params[@"category_name"] = @"all";
        params[@"tag_name"] = @"";

    }

    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/m/explore_album_list" params:params success:^(id json) {
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
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"condition"] = @"recent";
    params[@"device"] = @"android";
    params[@"page"] = @1;
    params[@"per_page"] = @20;
    params[@"status"] = @0;
    if (self.tag_name) {
        params[@"category_name"] = self.category_name;
        params[@"tag_name"] = self.tag_name;
    }else{
        params[@"category_name"] = @"all";
        params[@"tag_name"] = @"";

    }

    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/m/explore_album_list" params:params success:^(id json) {
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
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"condition"] = @"recent";
    params[@"device"] = @"android";
    params[@"page"] = @(self.currrentPage);
    params[@"per_page"] = @20;
    params[@"status"] = @0;
    if (self.tag_name) {
        params[@"category_name"] = self.category_name;
        params[@"tag_name"] = self.tag_name;
    }else{
        params[@"category_name"] = @"all";
        params[@"tag_name"] = @"";

    }


    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/m/explore_album_list" params:params success:^(id json) {
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
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"condition"] = @"classic";
    params[@"device"] = @"android";
    params[@"page"] = @1;
    params[@"per_page"] = @20;
    params[@"status"] = @0;
    if (self.tag_name) {
        params[@"category_name"] = self.category_name;
        params[@"tag_name"] = self.tag_name;
    }else{
        params[@"category_name"] = @"all";
        params[@"tag_name"] = @"";

    }


    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/m/explore_album_list" params:params success:^(id json) {
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

    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"condition"] = @"classic";
    params[@"device"] = @"android";
    params[@"page"] = @(self.currrentPage);
    params[@"per_page"] = @20;
    params[@"status"] = @0;
    if (self.tag_name) {
        params[@"category_name"] = self.category_name;
        params[@"tag_name"] = self.tag_name;
    }else{
        params[@"category_name"] = @"all";
        params[@"tag_name"] = @"";

    }
    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/m/explore_album_list" params:params success:^(id json) {
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
        self.album = albumTrack.album;
        self.totalCount = albumTrack.tracks.totalCount;
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
- ( void)fetchAlbumDeailDataWithPage:(NSUInteger)page success:(void (^)(void ))success failure:(void (^)(void ))failure{
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%@/true/%ld/50",self.ID,page] params:nil success:^(id json) {
        [self.trarkLists removeAllObjects];
        RCAlbumTrack  * albumTrack  = [RCAlbumTrack objectWithKeyValues:json];
        [self.downloadLists removeAllObjects];
        [self.downloadLists addObjectsFromArray:albumTrack.tracks.list];
        self.album = albumTrack.album;
        self.totalCount = albumTrack.tracks.totalCount;
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


- ( void)fetchNewTagAlbumWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    NSMutableDictionary *  params = [NSMutableDictionary dictionary];
    params[@"tname"] = self.tag;
    params[@"sort"] = @"hot";
    params[@"device"] = @"android";
    params[@"page"] = @1;

    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/m/tags/get_albums" params:params success:^(id json) {
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
- ( void)fetchMoreTagAlbumWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    self.currrentPage ++;
    NSMutableDictionary *  params = [NSMutableDictionary dictionary];
    params[@"tname"] = self.tag;
    params[@"sort"] = @"hot";
    params[@"device"] = @"android";
    params[@"page"] =  @(self.currrentPage);
    [RCNetWorkingTool get:@"http://mobile.ximalaya.com/m/tags/get_albums" params:params success:^(id json) {
        NSArray * newAudios = [RCAlbum objectArrayWithKeyValuesArray:json[@"list"]];
        [self.models addObjectsFromArray:newAudios];
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
- ( void)fetchAboutAlbumWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{

    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://ar.ximalaya.com/rec-association/recommend/album/by_album?albumId=%@&device=android",self.albumId] params:nil success:^(id json) {
        NSArray * newAudios = [RCAlbum objectArrayWithKeyValuesArray:json[@"albums"]];
        [self.aboutAlbumlists addObjectsFromArray:newAudios];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];

}

- (NSInteger)numberOfRowOfAboutAlbumlistInSection: (NSInteger)section{
    return self.aboutAlbumlists.count;

}
- (RCAlbum *)aboutAlbumListAtIndexPath: (NSIndexPath *)indexPath{
    return self.aboutAlbumlists[indexPath.row];

}
@end
