//
//  RCSearchConditionViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseViewModel.h"
@interface RCSearchConditionViewModel : RCBaseViewModel
@property(nonatomic,strong) NSMutableArray  *albums;
@property(nonatomic,strong) NSMutableArray  *users;
@property(nonatomic,strong) NSMutableArray  *tracks;
/**
 *  所有
 *
 */
- ( void)fetchNewAllWithCondition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreAllWithCondition:(NSString *)condition success:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;
/**
 *  找专辑
 *
 */
- ( void)fetchNewAlbumWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreAlbumWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;

/**
 *  找人
 *
 */
- ( void)fetchNewUserWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreUserWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;
/**
 *  找声音
 *
 */
- ( void)fetchNewVoiceWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreVoiceAllWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;
@end
