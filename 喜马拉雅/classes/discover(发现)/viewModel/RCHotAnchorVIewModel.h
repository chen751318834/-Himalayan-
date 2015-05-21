//
//  RCHotAnchorVIewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/21.
//  Copyright (c) 2015年 raychen. All rights reserved.
//Hot Anchor(最火主播)

#import <Foundation/Foundation.h>
#import "RCAnchorList.h"
@interface RCHotAnchorVIewModel : NSObject
/**
 *  tableview
 */
- (RCAnchorList *)rowAtIndexPathInTableView: (NSIndexPath *)indexPath;
@property(nonatomic,strong) NSMutableArray  *anchors;


/**
 *  网络请求
 */
- ( void)fetchNewHotAnchorDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
- ( void)fetchMoreHotAnchorDataWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;

@end
