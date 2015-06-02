//
//  RCPlayerVIewModel.h
//  喜马拉雅
//
//  Created by Raychen on 15/5/30.
//  Copyright (c) 2015年 raychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCPlayerInfo.h"
@interface RCPlayerVIewModel : NSObject
- ( void)fetchplayerInfoWithSuccess:(void (^)(void ))success failure:(void (^)(void ))failure;
@property(nonatomic,strong) RCPlayerInfo  *playerInfo;
@property(nonatomic,strong) NSNumber  *trackId;
@end
