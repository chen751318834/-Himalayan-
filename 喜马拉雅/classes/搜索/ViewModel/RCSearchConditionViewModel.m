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

#import "RCConditionAlbum.h"
#import "RCConditionUser.h"
#import "RCConditionVoice.h"
#import "RCConditionResponse.h"
#import "RCConditionResponseDoc.h"
@interface RCSearchConditionViewModel ()

@end
@implementation RCSearchConditionViewModel
#pragma mark -  找所有

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
        self.track = all.track;
        self.album = all.album;
        self.user = all.user;
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

#pragma mark -  找专辑
-  (NSMutableArray *)responseDocs{
    if (!_responseDocs) {
        self.responseDocs = [NSMutableArray array];
    }
    return _responseDocs;
}
- ( void)fetchNewAlbumWithDataType:(albumDataType)dataType condition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"device"] = @"android";
    params[@"condition"] =condition;
    params[@"page"] = @1;
    params[@"per_page"] = @20;
    params[@"scope"] = @"album";
    switch (dataType) {
        case albumDataTypeInvolve:

            break;
        case albumDataTypeRecent:
            params[@"sort"] = @"recent";

            break;
        case albumDataTypePaly:
            params[@"sort"] = @"play";

            break;

        default:
            break;
    }
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/s/mobile/search"] params:params success:^(id json) {
        RCConditionAlbum * album = [RCConditionAlbum objectWithKeyValues:json];
        [self.responseDocs removeAllObjects];
        [self.responseDocs addObjectsFromArray:album.response.docs];
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
    

}
- ( void)fetchMoreAlbumWithDataType:(albumDataType)dataType condition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    self.currrentPage ++;

    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"device"] = @"android";
    params[@"condition"] =condition;
    params[@"page"] = @(self.currrentPage);
    params[@"per_page"] = @20;
    params[@"scope"] = @"album";
    switch (dataType) {
        case albumDataTypeInvolve:
            break;
        case albumDataTypeRecent:
            params[@"sort"] = @"recent";

            break;
        case albumDataTypePaly:
            params[@"sort"] = @"play";

            break;

        default:
            break;
    }
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/s/mobile/search"] params:params success:^(id json) {
        RCConditionAlbum * album = [RCConditionAlbum objectWithKeyValues:json];
        [self.responseDocs addObjectsFromArray:album.response.docs];
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
    


}

#pragma mark -    找人
-  (NSMutableArray *)responseUserDocs{
    if (!_responseUserDocs) {
        self.responseUserDocs = [NSMutableArray array];
    }
    return _responseUserDocs;
}
- ( void)fetchNewUserWithDataType:(userDataType)dataType condition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure{

    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"device"] = @"android";
    params[@"condition"] =condition;
    params[@"page"] = @1;
    params[@"per_page"] = @20;
    params[@"scope"] = @"user";
    switch (dataType) {
        case albumDataTypeInvolve:

            break;
        case albumDataTypeRecent:
            params[@"sort"] = @"fans";

            break;
        case albumDataTypePaly:
            params[@"sort"] = @"voice";

            break;

        default:
            break;
    }
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/s/mobile/search"] params:params success:^(id json) {
        RCConditionUser * all = [RCConditionUser objectWithKeyValues:json];
        [self.responseUserDocs removeAllObjects];
        [self.responseUserDocs addObjectsFromArray:all.response.docs];
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];

}
- ( void)fetchMoreUserWithDataType:(userDataType)dataType condition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    self.currrentPage ++;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"device"] = @"android";
    params[@"condition"] =condition;
    params[@"page"] = @(self.currrentPage);
    params[@"per_page"] = @20;
    params[@"scope"] = @"user";
    switch (dataType) {
        case albumDataTypeInvolve:
            break;
        case albumDataTypeRecent:
            params[@"sort"] = @"recent";

            break;
        case albumDataTypePaly:
            params[@"sort"] = @"play";

            break;

        default:
            break;
    }
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/s/mobile/search"] params:params success:^(id json) {
        RCConditionUser * all = [RCConditionUser objectWithKeyValues:json];
        [self.responseUserDocs addObjectsFromArray:all.response.docs];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];

}

#pragma mark -   找声音
- (NSMutableArray *)responseVoiceDocs{
    if (!_responseVoiceDocs) {
        self.responseVoiceDocs = [NSMutableArray array];
    }
    return _responseVoiceDocs;
}
- ( void)fetchNewVoiceWithDataType:(voiceDataType)dataType condition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure{

    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"device"] = @"android";
    params[@"condition"] =condition;
    params[@"page"] = @1;
    params[@"per_page"] = @20;
    params[@"scope"] = @"voice";
    switch (dataType) {
        case albumDataTypeInvolve:

            break;
        case albumDataTypeRecent:
            params[@"sort"] = @"recent";

            break;
        case albumDataTypePaly:
            params[@"sort"] = @"play";

            break;

        default:
            break;
    }
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/s/mobile/search"] params:params success:^(id json) {
        RCConditionVoice * all = [RCConditionVoice objectWithKeyValues:json];
        [self.responseVoiceDocs removeAllObjects];
        [self.responseVoiceDocs addObjectsFromArray:all.response.docs];
        if (success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];

}
- ( void)fetchMoreVoiceWithDataType:(voiceDataType)dataType condition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    self.currrentPage ++;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"device"] = @"android";
    params[@"condition"] =condition;
    params[@"page"] = @(self.currrentPage);
    params[@"per_page"] = @20;
    params[@"scope"] = @"voice";
    switch (dataType) {
        case albumDataTypeInvolve:
            break;
        case albumDataTypeRecent:
            params[@"sort"] = @"recent";

            break;
        case albumDataTypePaly:
            params[@"sort"] = @"play";
            break;
        default:
            break;
    }
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/s/mobile/search"] params:params success:^(id json) {
        RCConditionVoice * all = [RCConditionVoice objectWithKeyValues:json];
        [self.responseVoiceDocs addObjectsFromArray:all.response.docs];
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
