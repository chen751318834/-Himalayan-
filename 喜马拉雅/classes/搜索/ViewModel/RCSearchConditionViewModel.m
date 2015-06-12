//
//  RCSearchConditionViewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSearchConditionViewModel.h"
#import "RCconditionOfAllTrack.h"
#import "RCconditionOfAllAlbum.h"
#import "RCconditionOfAllUser.h"
#import "RCconditionOfAllAlbumDoc.h"
#import "RCconditionOfAllUserDoc.h"
#import "RCconditionOfAllTrackDoc.h"
#import "RCconditionAll.h"
#import "RCNetWorkingTool.h"
#import "MJExtension.h"
#import "NSURLConnection+RACSupport.h"
@interface RCSearchConditionViewModel ()

@end
@implementation RCSearchConditionViewModel
-  (NSMutableArray *)albums{
    if (!_albums) {
         self.albums = [NSMutableArray array];

    }
    return _albums;
}
-  (NSMutableArray *)users{
    if (!_users) {
        self.users = [NSMutableArray array];

    }
    return _users;
}
-  (NSMutableArray *)tracks{
    if (!_tracks) {
        self.tracks = [NSMutableArray array];

    }
    return _tracks;
}
/**
 *  所有
 *
 */
- ( void)fetchNewAllWithCondition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"device"] = @"android";
    params[@"condition"] =condition;
    params[@"page"] = @1;
    params[@"per_page"] = @3;
    params[@"scope"] = @"all";
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/s/mobile/search"] params:params success:^(id json) {
        RCconditionAll * all = [RCconditionAll objectWithKeyValues:json];
        [self.tracks removeAllObjects];
        [self.users removeAllObjects];
        [self.albums removeAllObjects];
        [self.tracks addObjectsFromArray:all.track.docs];
        [self.albums addObjectsFromArray:all.album.docs];
        [self.users addObjectsFromArray:all.user.docs];
        NSLog(@"%d----%d-----%d",self.tracks.count,self.albums.count,self.users.count);
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];

}
- ( void)fetchMoreAllWithCondition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    self.currrentPage ++;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"device"] = @"android";
    params[@"condition"] =condition;
    params[@"page"] = @(self.currrentPage);
    params[@"per_page"] = @20;
    params[@"scope"] = @"all";
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/s/mobile/search"] params:params success:^(id json) {
        RCconditionAll * all = [RCconditionAll objectWithKeyValues:json];
        [self.tracks addObjectsFromArray:all.track.docs];
        [self.albums addObjectsFromArray:all.album.docs];
        [self.users addObjectsFromArray:all.user.docs];
//        NSNumber *  maxPageID = all.track.numFound;
//        if (self.currrentPage  > [maxPageID integerValue]) {
//            if (completion) {
//                completion();
//            }
//            return ;
//        }
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];

}
///**
// *  找专辑
// *
// */
//- ( void)fetchNewAlbumWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
//    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/following?device=android&pageSize=15&toUid=%@&pageId=1",self.ID] params:nil success:^(id json) {
//        NSArray * newAudios = [RCUserDeialList objectArrayWithKeyValuesArray:json[@"list"]];
//        [self.models removeAllObjects];
//        [self.models addObjectsFromArray:newAudios];
//        if (success) {
//            success();
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure();
//            NSLog(@"%@",error);
//        }
//
//}
//- ( void)fetchMoreAlbumWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
//    self.currrentPage ++;
//    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/following?device=android&pageSize=15&toUid=%@&pageId=%ld",self.ID,self.currrentPage] params:nil success:^(id json) {
//        NSArray * newAudios = [RCUserDeialList objectArrayWithKeyValuesArray:json[@"list"]];
//        NSNumber *  maxPageID = (NSNumber *)json[@"maxPageId"];
//        if (self.currrentPage  > [maxPageID integerValue]) {
//            if (completion) {
//                completion();
//            }
//            return ;
//        }
//        [self.models addObjectsFromArray:newAudios];
//        if (success) {
//            success();
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure();
//        }
//    }];
//
//}
//
///**
// *  找人
// *
// */
//- ( void)fetchNewUserWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
//    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/following?device=android&pageSize=15&toUid=%@&pageId=1",self.ID] params:nil success:^(id json) {
//        NSArray * newAudios = [RCUserDeialList objectArrayWithKeyValuesArray:json[@"list"]];
//        [self.models removeAllObjects];
//        [self.models addObjectsFromArray:newAudios];
//        if (success) {
//            success();
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure();
//            NSLog(@"%@",error);
//        }
//}
//- ( void)fetchMoreUserWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
//    self.currrentPage ++;
//    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/following?device=android&pageSize=15&toUid=%@&pageId=%ld",self.ID,self.currrentPage] params:nil success:^(id json) {
//        NSArray * newAudios = [RCUserDeialList objectArrayWithKeyValuesArray:json[@"list"]];
//        NSNumber *  maxPageID = (NSNumber *)json[@"maxPageId"];
//        if (self.currrentPage  > [maxPageID integerValue]) {
//            if (completion) {
//                completion();
//            }
//            return ;
//        }
//        [self.models addObjectsFromArray:newAudios];
//        if (success) {
//            success();
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure();
//        }
//    }];
//
//}
///**
// *  找声音
// *
// */
//- ( void)fetchNewVoiceWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
//
//}
//- ( void)fetchMoreVoiceAllWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
//    self.currrentPage ++;
//    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/following?device=android&pageSize=15&toUid=%@&pageId=%ld",self.ID,self.currrentPage] params:nil success:^(id json) {
//        NSArray * newAudios = [RCUserDeialList objectArrayWithKeyValuesArray:json[@"list"]];
//        NSNumber *  maxPageID = (NSNumber *)json[@"maxPageId"];
//        if (self.currrentPage  > [maxPageID integerValue]) {
//            if (completion) {
//                completion();
//            }
//            return ;
//        }
//        [self.models addObjectsFromArray:newAudios];
//        if (success) {
//            success();
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure();
//        }
//    }];
//
//
//}
////
@end
