//
//  RCHotAnchorVIewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCHotAnchorVIewModel.h"
#import "RCNetWorkingTool.h"
#import "RCAnchorList.h"
#import "RCConst.h"
#import "RCOneAnchorList.h"
@interface RCHotAnchorVIewModel ()
@end
@implementation RCHotAnchorVIewModel


- ( void)fetchNewHotAnchorDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_user_index?device=android&page=1"] params:nil success:^(id json) {
        NSArray * newAnthors = [RCAnchorList objectArrayWithKeyValuesArray:json[@"list"]];
        [self.models removeAllObjects];
        [self.models addObjectsFromArray:newAnthors];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}
- ( void)fetchMoreHotAnchorDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    self.currrentPage ++;
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_user_index?device=android&page=%ld",self.currrentPage] params:nil success:^(id json) {
        NSArray * newAnthors = [RCAnchorList objectArrayWithKeyValuesArray:json[@"list"]];
        [self.models addObjectsFromArray:newAnthors];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}

- (RCAnchorList *)rowAtIndexPathInTableView: (NSIndexPath *)indexPath{
    return self.models[indexPath.row];

}
@end
