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

#import "RCSearchUserResult.h"
#import "RCSearchAllResult.h"
#import "MJExtension.h"
#import "RCNetWorkingTool.h"
#import "RCSearchResultList.h"
#import "RCUserlAudioOrAlbumList.h"
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
-  (NSMutableArray *)historySearchTexts{
    if (!_historySearchTexts) {
        self.historySearchTexts = [NSMutableArray array];
    }
    return _historySearchTexts;
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
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/track/%@/1/30",self.ID] params:nil success:^(id json) {
        RCSearchUserInfo * userInfo = [RCSearchUserInfo objectWithKeyValues:json];
        self.userInfo = userInfo;
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
            NSArray * newAudios = [RCUserlAudioOrAlbumList objectArrayWithKeyValuesArray:json[@"list"]];
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
        NSArray * newAudios = [RCUserlAudioOrAlbumList objectArrayWithKeyValuesArray:json[@"list"]];
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

@end
