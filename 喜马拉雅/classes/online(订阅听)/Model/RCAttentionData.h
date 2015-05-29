//
//  RCAttentionData.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/29.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCAttentionData : NSObject
/**
 *    "datas": [],
 "ret": 0,
 "frDatas": [],
 "frTotalSize": 10,
 "totalSize": 3,
 */
@property(nonatomic,strong) NSNumber  *frTotalSize;
@property(nonatomic,strong) NSNumber  *totalSize;
@property(nonatomic,strong) NSArray  *datas;
@property(nonatomic,strong) NSArray  *frDatas;
@end
