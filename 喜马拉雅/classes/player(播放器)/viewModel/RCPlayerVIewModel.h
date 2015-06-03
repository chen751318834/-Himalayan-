//
//  RCPlayerVIewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCPlayerInfo.h"
#import "RCPlayerCommnet.h"
#import "RCPlayerTrackDeail.h"
#import "RCBaseViewModel.h"
#import "RCPlayerAlbum.h"
@interface RCPlayerVIewModel : RCBaseViewModel
@property(nonatomic,strong) NSMutableArray  *playerlists;
@property(nonatomic,strong) NSMutableArray  *comments;
@property(nonatomic,strong) NSMutableArray  *deails;
@property(nonatomic,strong) NSMutableArray  *albums;

- ( void)fetchplayerInfoWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
@property(nonatomic,strong) RCPlayerInfo  *playerInfo;
@property(nonatomic,strong) NSNumber  *trackId;
- ( void)fetchNewPlayerCommnetWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMorePlayerCommnetWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;

- ( void)fetchPlayerTrackDeailWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchPlayerAlbumWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;

@end
