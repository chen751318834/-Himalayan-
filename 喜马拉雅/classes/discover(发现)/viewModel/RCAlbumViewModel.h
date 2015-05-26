//
//  RCAlbumViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/25.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseViewModel.h"
#import "RCOneAlbum.h"

#import "RCTrackList.h"
@interface RCAlbumViewModel : RCBaseViewModel
/**
 *  网络请求
 */
- ( void)fetchNewHotAlbumDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreHotAlbumDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;

- ( void)fetchNewReccentAlbumDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreReccentAlbumDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;

- ( void)fetchNewClassicsDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreClassicsDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;




/**
 *  专辑详情
 */
- ( void)fetchNewAlbumDeailDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreAlbumDeailDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;

- (NSInteger)numberOfRowOfAlbumDeailDataInSection: (NSInteger)section;
- (RCTrackList *)trackListAtIndexPath: (NSIndexPath *)indexPath;
@property(nonatomic,strong) NSNumber  *ID;
@property(nonatomic,strong) RCOneAlbum  *album;
@property(nonatomic,strong) NSNumber  *totalCount;
@end
