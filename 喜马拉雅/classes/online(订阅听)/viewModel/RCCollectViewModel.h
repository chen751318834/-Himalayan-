//
//  RCCollectViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCAlbum.h"
#import "RCSingleInstance.h"
@interface RCCollectViewModel : NSObject

- (void)loadNewAlbumsWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure ;
- (void)loadMoreAlbumsWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;
- (NSInteger)numberOfRowAlbumlistInSection: (NSInteger)section;
- (RCAlbum *)AlbumListAtIndexPath: (NSIndexPath *)indexPath;
-(NSUInteger)albumCount;
@end
