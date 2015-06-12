//
//  RCSearchViewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSearchViewModel.h"
#import "RCSearchSoundResult.h"
#import "RCSearchAlbumResult.h"
#import "RCAlbum.h"
#import "RCTrackList.h"
#import "RCUserDeialList.h"
#import "RCSearchUserResult.h"
#import "RCConst.h"
#import "RCSearchAllResult.h"
#import "MJExtension.h"
#import "RCNetWorkingTool.h"
#import "RCSearchResultList.h"
#import "RCUserAudio.h"
@implementation RCSearchViewModel
-  (NSMutableArray *)userAlbums{
    if (!_userAlbums) {
        self.userAlbums = [NSMutableArray array];
    }
    return _userAlbums;
}
-  (NSMutableArray *)userAudios{
    if (!_userAudios) {
        self.userAudios = [NSMutableArray array];
    }
    return _userAudios;
}
-  (NSMutableArray *)hotSearchTexts{
    if (!_hotSearchTexts) {
        self.hotSearchTexts = [NSMutableArray array];
    }
    return _hotSearchTexts;
}
- (void)fetchHotSearchWithSuccess:(void (^)(void))success failure:(void (^)(void))failure{

    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/hot_search_keys"] params:nil success:^(id json) {
        NSArray * hotTexts = json[@"keys"];
        [self.hotSearchTexts addObjectsFromArray:hotTexts];
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
- (void)fetchhotSearchDataWithIndex:(RCSearchViewModelDataType)dataType keywords:(NSString *)keywords success:(void (^)(void))success failure:(void (^)(void))failure{
    NSString * urlStr = nil;

    switch (dataType) {
        case RCSearchViewModelDataTypeAll:
              urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/s/search/suggest?device=android&keywords=%@&scope=all",keywords];
            break;
        case RCSearchViewModelDataTypeAlbum:
            urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/s/search/suggest?device=android&keywords=%@&scope=album",keywords];;
            break;
        case RCSearchViewModelDataTypeuser:
            urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/s/search/suggest?device=android&keywords=%@&scope=user",keywords];;
            break;
        case RCSearchViewModelDataTypeAudio:
            urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/s/search/suggest?device=android&keywords=%@&scope=sound",keywords];;
            break;

    }
    [RCNetWorkingTool get:urlStr params:nil success:^(id json) {
        [self.models removeAllObjects];
        switch (dataType) {
            case RCSearchViewModelDataTypeAll:{
                RCSearchAllResult * all  = [RCSearchAllResult objectWithKeyValues:json];
                [self.models addObjectsFromArray:all.album.list];
                [self.models addObjectsFromArray:all.sound.list];
                [self.models addObjectsFromArray:all.user.list];
                if ([all.scope isEqualToString: @"album"]) {

                }else if ([all.scope isEqualToString: @"user"]){


                }else if ([all.scope isEqualToString: @"sound"]){

                }
                self.resultDataType = RCSearchViewModelDataTypeAll;


            }
                break;
            case RCSearchViewModelDataTypeAlbum:
                [self.models addObjectsFromArray:[RCSearchResultList objectArrayWithKeyValuesArray:json[@"list"]]];
                self.resultDataType = RCSearchViewModelDataTypeAlbum;

                break;
            case RCSearchViewModelDataTypeuser:
                [self.models addObjectsFromArray:[RCSearchResultList objectArrayWithKeyValuesArray:json[@"list"]]];
                self.resultDataType = RCSearchViewModelDataTypeuser;
                break;
            case RCSearchViewModelDataTypeAudio:
                [self.models addObjectsFromArray:[RCSearchResultList objectArrayWithKeyValuesArray:json[@"list"]]];
                self.resultDataType = RCSearchViewModelDataTypeAudio;
                break;
                    }

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


- ( void)fetchUserInfoWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{


    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/homePage?device=android&toUid=%@",self.ID] params:nil success:^(id json) {
        RCSearchUserInfo * userInfo = [RCSearchUserInfo objectWithKeyValues:json];
        self.userInfo = userInfo;
        [RCNotificationCenter postNotificationName:searchUserInfoNotification object:nil userInfo:@{searchUserInfoNotificationName:userInfo}];
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
- ( void)fetchUserAlbumsWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
            [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/track/%@/1/30",self.ID] params:nil success:^(id json) {
            NSArray * newAudios = [RCAlbum objectArrayWithKeyValuesArray:json[@"list"]];
            [self.userAlbums addObjectsFromArray:newAudios];
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
- ( void)fetchUserAudiosWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{

    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/%@/1/2",self.ID] params:nil success:^(id json) {
        NSArray * newAudios = [RCTrackList objectArrayWithKeyValuesArray:json[@"list"]];
        NSNumber *  maxPageID = (NSNumber *)json[@"maxPageId"];
        if (self.currrentPage  > [maxPageID integerValue]) {
            if (completion) {
                completion();
            }
            return ;
        }
        [self.userAudios addObjectsFromArray:newAudios];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}
- ( void)fetchNewUserOfFollowerWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/following?device=android&pageSize=15&toUid=%@&pageId=1",self.ID] params:nil success:^(id json) {
        NSArray * newAudios = [RCUserDeialList objectArrayWithKeyValuesArray:json[@"list"]];
        [self.models removeAllObjects];
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

- ( void)fetchNewUserFansWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure {
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/follower?device=android&pageSize=15&toUid=%@&pageId=1",self.ID] params:nil success:^(id json) {
        NSArray * newAudios = [RCUserDeialList objectArrayWithKeyValuesArray:json[@"list"]];
        [self.models removeAllObjects];

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

- ( void)fetchNewUserZanedWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure {
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/favorite?device=android&pageSize=15&toUid=%@&pageId=1",self.ID] params:nil success:^(id json) {
        NSArray * newAudios = [RCTrackList objectArrayWithKeyValuesArray:json[@"list"]];
        [self.models removeAllObjects];

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

- ( void)fetchMoreUserOfFollowerWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    self.currrentPage ++;
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/following?device=android&pageSize=15&toUid=%@&pageId=%ld",self.ID,self.currrentPage] params:nil success:^(id json) {
        NSArray * newAudios = [RCUserDeialList objectArrayWithKeyValuesArray:json[@"list"]];
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

- ( void)fetchMoreUserFansWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    self.currrentPage ++;
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/follower?device=android&pageSize=15&toUid=%@&pageId=%ld",self.ID,self.currrentPage] params:nil success:^(id json) {
        NSArray * newAudios = [RCUserDeialList objectArrayWithKeyValuesArray:json[@"list"]];
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

- ( void)fetchMoreUserZanedWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    self.currrentPage ++;
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/favorite?device=android&pageSize=15&toUid=%@&pageId=%ld",self.ID,self.currrentPage] params:nil success:^(id json) {
        NSArray * newAudios = [RCTrackList objectArrayWithKeyValuesArray:json[@"list"]];
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

@end
