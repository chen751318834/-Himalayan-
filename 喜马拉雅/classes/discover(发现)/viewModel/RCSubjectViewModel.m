//
//  RCSubjectViewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCSubjectViewModel.h"
#import "RCNetWorkingTool.h"
#import "RCConst.h"
#import "RCSubjectList.h"
@implementation RCSubjectViewModel
- ( void)fetchNewSubjectDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/subject_list?device=android&page=1&per_page=10"] params:nil success:^(id json) {
        [self.models removeAllObjects];
        NSArray * newAudios = [RCSubjectList objectArrayWithKeyValuesArray:json[@"list"]];
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
- ( void)fetchMoreSubjectDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure{
    self.currrentPage ++;
    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/subject_list?device=android&page=%ld&per_page=10",self.currrentPage] params:nil success:^(id json) {
        NSArray * newAudios = [RCSubjectList objectArrayWithKeyValuesArray:json[@"list"]];
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
