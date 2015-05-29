//
//  RCAttentionViewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCNetWorkingTool.h"
#import "RCAttentionOneData.h"
#import "RCAttentionFrData.h"
@interface RCAttentionViewModel : NSObject
- (void)fetchAttentionDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure ;
- (NSInteger)numberOfRowInSection: (NSInteger)section;
- (RCAttentionOneData *)dataAtIndexPath: (NSIndexPath *)indexPath;
- (RCAttentionFrData *)frDataAtIndexPath: (NSIndexPath *)indexPath;

@end
