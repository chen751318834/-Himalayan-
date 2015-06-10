//
//  RCSearchViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/9.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseViewModel.h"
#import "RCSearchUserInfo.h"
typedef enum {
    RCSearchViewModelDataTypeAll,
    RCSearchViewModelDataTypeAlbum,
    RCSearchViewModelDataTypeuser,
    RCSearchViewModelDataTypeAudio,
}RCSearchViewModelDataType;
@interface RCSearchViewModel : RCBaseViewModel
@property(nonatomic,strong) NSMutableArray  *historySearchTexts;
@property(nonatomic,strong) NSMutableArray  *hotSearchTexts;

/**
 *  搜索
 *
 */
- ( void)fetchhotSearchDataWithIndex:(RCSearchViewModelDataType )dataType keywords:(NSString *)keywords success:(void (^)(void ))success failure:(void (^)(void ))failure;
@property(nonatomic,assign) RCSearchViewModelDataType resultDataType;
/**
 * 用户
 *
 */
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) NSMutableArray  *userAlbums;
@property(nonatomic,strong) NSMutableArray  *userAudios;
@property(nonatomic,strong) RCSearchUserInfo  *userInfo;
- ( void)fetchUserInfoWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;

- ( void)fetchUserAlbumsWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchUserAudiosWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;

@end
