//
//  RCAttentionViewModel.m
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCAttentionViewModel.h"
#import "MJExtension.h"
#import <UIKit/UIKit.h>
#import "RCAttentionData.h"
@interface RCAttentionViewModel ()
@property(nonatomic,strong) NSMutableArray  *attentionDatas;
@property(nonatomic,strong) NSMutableArray  *attentionFrDatas;

@end
@implementation RCAttentionViewModel
-  (NSMutableArray *)attentionFrDatas{
    if (!_attentionFrDatas) {
        self.attentionFrDatas = [NSMutableArray array];

    }
    return _attentionFrDatas;
}
-  (NSMutableArray *)attentionDatas{
    if (!_attentionDatas) {
         self.attentionDatas = [NSMutableArray array];

    }
    return _attentionDatas;
}
- (void)fetchAttentionDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure {

    [RCNetWorkingTool get:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/api/1/feed/recommend/dynamic?device=android&sign=2&size=30&token=02d23a020a64b044590a121063bb338ab22d&uid=18633853"] params:nil success:^(id json) {
        RCAttentionData  * attentionData  = [RCAttentionData objectWithKeyValues:json];
        [self.attentionDatas addObjectsFromArray:attentionData.datas];
        [self.attentionFrDatas addObjectsFromArray:attentionData.frDatas];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];

}
- (NSInteger)numberOfRowInSection: (NSInteger)section{
    if (section == 0) {
        return self.attentionDatas.count;
    }
    return self.attentionFrDatas.count;

}
- (RCAttentionOneData *)dataAtIndexPath: (NSIndexPath *)indexPath{
    return self.attentionDatas[indexPath.row];

}
- (RCAttentionFrData *)frDataAtIndexPath: (NSIndexPath *)indexPath{

    return self.attentionFrDatas[indexPath.row];
}
@end
