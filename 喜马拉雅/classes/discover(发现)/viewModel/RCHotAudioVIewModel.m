//
//  RCHotAudioVIewModel\.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCHotAudioVIewModel.h"
#import "RCNetWorkingTool.h"
#import "MJExtension.h"
#import "RCOnneHotAudio.h"
#import "RCHotAudio.h"
#import <UIKit/UIKit.h>
@implementation RCHotAudioVIewModel
- ( void)fetchNewHotAudioDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{

    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_track_list?category_name=all&condition=daily&device=android&page=1&per_page=15&tag_name="] params:nil success:^(id json) {
        [self.models removeAllObjects];
        NSArray * newAudios = [RCOnneHotAudio objectArrayWithKeyValuesArray:json[@"list"]];
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
- ( void)fetchMoreHotAudioDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    self.currrentPage ++;
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_track_list?category_name=all&condition=daily&device=android&page=%ld&per_page=15&tag_name=",self.currrentPage] params:nil success:^(id json) {
        NSArray * newAudios = [RCOnneHotAudio objectArrayWithKeyValuesArray:json[@"list"]];
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
- ( void)fetchNewWeekHotAudioDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_track_list?category_name=all&condition=hot&device=android&page=1&per_page=15&tag_name="] params:nil success:^(id json) {
        [self.models removeAllObjects];
        NSArray * newAudios = [RCOnneHotAudio objectArrayWithKeyValuesArray:json[@"list"]];
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
- ( void)fetchMoreWeekHotAudioDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    self.currrentPage ++;
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_track_list?category_name=all&condition=hot&device=android&page=%ld&per_page=15&tag_name=",self.currrentPage] params:nil success:^(id json) {
        NSArray * newAudios = [RCOnneHotAudio objectArrayWithKeyValuesArray:json[@"list"]];
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

- ( void)fetchNewLikeAudioDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_track_list?category_name=all&condition=favorite&device=android&page=1&per_page=15&tag_name="] params:nil success:^(id json) {
        [self.models removeAllObjects];
        NSArray * newAudios = [RCOnneHotAudio objectArrayWithKeyValuesArray:json[@"list"]];
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
- ( void)fetchMoreLikeAudioDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{

    self.currrentPage ++;
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_track_list?category_name=all&condition=favorite&device=android&page=%ld&per_page=15&tag_name=",self.currrentPage] params:nil success:^(id json) {
        NSArray * newAudios = [RCOnneHotAudio objectArrayWithKeyValuesArray:json[@"list"]];
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




- (RCHotAudio *)rowAtIndexPathInTableView:(NSIndexPath *)indexPath{

    return self.models[indexPath.row];
}
@end
