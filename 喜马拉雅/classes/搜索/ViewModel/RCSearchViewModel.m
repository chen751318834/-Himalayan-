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
#import "RCSearchResultList.h"
@implementation RCSearchViewModel
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
    
            }
                break;
            case RCSearchViewModelDataTypeAlbum:
                [self.models addObjectsFromArray:[RCSearchResultList objectArrayWithKeyValuesArray:json[@"list"]]];

                break;
            case RCSearchViewModelDataTypeuser:
                [self.models addObjectsFromArray:[RCSearchResultList objectArrayWithKeyValuesArray:json[@"list"]]];


                break;
            case RCSearchViewModelDataTypeAudio:
                [self.models addObjectsFromArray:[RCSearchResultList objectArrayWithKeyValuesArray:json[@"list"]]];
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
@end
