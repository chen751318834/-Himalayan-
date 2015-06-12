//
//  RCConditionAlbumResponseHeader.h
//  喜马拉雅
//
//  Created by Raychen on 15/6/12.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCConditionResponseHeaderParam.h"
@interface RCConditionResponseHeader : NSObject
/**
 *     "status": 0,
 "QTime": 3,
 "params": {}
 */
@property(nonatomic,strong) NSNumber  *status;
@property(nonatomic,strong) NSNumber  *QTime;
@property(nonatomic,strong) RCConditionResponseHeaderParam  *params;
@end
