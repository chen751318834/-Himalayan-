//
//  RCSubjectViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/22.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import "RCBaseViewModel.h"

@interface RCSubjectViewModel : RCBaseViewModel
/**
 *  网络请求
 */
- ( void)fetchNewSubjectDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreSubjectDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
@end
