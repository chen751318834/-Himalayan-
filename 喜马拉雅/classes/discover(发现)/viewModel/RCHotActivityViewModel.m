//
//  RCHotActivityViewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCHotActivityViewModel.h"
#import "RCHotActivity.h"
@implementation RCHotActivityViewModel
/**
 *  网络请求
 */
- ( void)fetchNewDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://activity.ximalaya.com/activity-web/activity/activityList?device=android&pageId=1"] params:nil success:^(id json) {
        [self.models removeAllObjects];
        NSArray * newAudios = [RCHotActivity objectArrayWithKeyValuesArray:json[@"result"][@"activityData"]];
        [self.models addObjectsFromArray:newAudios];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        if (failure) {
            failure();
        }
    }];
}
- ( void)fetchMoreDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion{
    self.currrentPage ++;
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://activity.ximalaya.com/activity-web/activity/activityList?device=android&pageId=%ld",self.currrentPage] params:nil success:^(id json) {
        NSArray * newAudios = [RCHotActivity objectArrayWithKeyValuesArray:json[@"result"][@"activityData"]];
        NSNumber *  maxPageID = (NSNumber *)json[@"result"][@"maxPageId"];
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
