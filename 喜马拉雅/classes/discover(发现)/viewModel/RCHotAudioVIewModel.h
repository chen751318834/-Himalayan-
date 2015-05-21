//
//  RCHotAudioVIewModel\.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCBaseViewModel.h"
#import "RCHotAudio.h"
@interface RCHotAudioVIewModel : RCBaseViewModel
- (RCHotAudio *)rowAtIndexPathInTableView: (NSIndexPath *)indexPath;

/**
 *  网络请求
 */
- ( void)fetchNewHotAudioDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreHotAudioDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
@end
