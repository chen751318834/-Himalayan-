//
//  RCHotActivityViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCBaseViewModel.h"
@interface RCHotActivityViewModel : RCBaseViewModel
/**
 *  网络请求
 */
- ( void)fetchNewDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure ;
- ( void)fetchMoreDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure completion:(void (^)(void))completion;
@end
